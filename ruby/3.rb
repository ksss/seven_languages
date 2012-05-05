#! /usr/bin/env ruby

module ActsAsCsv

  def self.included (base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods

    class CsvRow
      def initialize headers, values
        @head = headers
        @values = values
      end

      def method_missing name, *args
        @values[@head.index(name.to_s)]
      end
    end

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase.gsub(/csv$/, '.csv')
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    def each
      @csv_contents.each do |row|
        yield CsvRow.new(@headers, row)
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

  end

end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
csv.each {|row| puts row.one}
