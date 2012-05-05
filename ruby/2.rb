#! /usr/bin/env ruby
require('pp')
# 1
puts "#use each"
a = []
(0..16).each do |i|
  a.push(i)
  if a.length % 4 === 0
    print a.join(','), "\n"
    a = []
  end
end
puts

puts "#use each_slice"
(0...16).each_slice(4) do |a|
  print a.join(','), "\n"
end
puts

#2
class Tree
  attr_accessor :children, :node_name

  def initialize(name, children=[])
    if name.kind_of? String
      @node_name = name
      @children = children
    elsif name.kind_of? Hash
      array = name.to_a.first
      @node_name = array.first
      @children = array.last.map {|k|
        Tree.new(Hash[*k])
      }
    end
  end

  def visit(&block)
    block.call self
  end

  def visit_all(&block)
    visit(&block)
    children.each {|c| c.visit_all &block}
  end
end

ruby_tree = Tree.new({
  'grandpa' => {
    'dad' => {
      'child 1' => [], 'child 2' => []
    },
    'uncle' => {
      'child 3' => [], 'child 4' => []
    }
  }
})

puts ruby_tree.node_name
puts
ruby_tree.visit {|node| puts node.node_name}
puts
ruby_tree.visit_all {|node| puts node.node_name}
puts

#3
def fgrep (filename, search, number=false)
  ret = ''
  File.open(filename, 'r') do |f|
    while(f.gets)
      if $_ =~ /(^.*#{search}.*$)/
        ret << (number ? "#{$.}	#{$1}\n" : "#{$1}\n")
      end
    end
  end
  ret
end
print fgrep('./2.rb', 'puts', true)
