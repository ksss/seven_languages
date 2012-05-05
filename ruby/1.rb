#! /usr/bin/env ruby

# 1
puts "Hello, world"

# 2
puts "Hello, Ruby".index("Ruby")

# 3
10.times {|i| puts 'ksss'}

# 4
1.upto(10) {|i|
  puts "This is sentence number #{i}"
}

# 5
puts system("./2.rb")

# 6
r = rand(10)
g = gets.to_i
ret = r < g ? "upper" : "lower"
puts "#{g} is #{ret} than random number #{r}"

