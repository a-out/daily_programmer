#!/usr/local/bin/ruby

vowels = ['a', 'e', 'i', 'o', 'u']
removed = ""

puts gets.chomp.split('').keep_if { |char|
   if !vowels.include?(char) && char != ' '
      true
   else
      removed << char unless char == ' '
      false
   end
}.join
puts removed
