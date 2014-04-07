#!/usr/local/bin/ruby

DICT_PATH = '/Users/richard/Downloads/enable1.txt'

def populate_dictionary(dict_path)
   dict_array = Array.new
   File.open(dict_path, "r").each_line { |line|
      dict_array << line.chomp
   }
   puts "dict_size: #{dict_array.size}"
   return dict_array
end

def insert_vowel_rand(phrase, vowel, lowest_pos)
   new_pos = rand(lowest_pos..phrase.size)
   puts "lowest_pos: #{lowest_pos}, new_pos: #{new_pos}"
   STDOUT.flush
   return phrase.insert(new_pos, vowel), new_pos
end

def insert_space_rand(phrase)
   index = rand(1..(phrase.size - 1))
   if phrase.at(index) != ' '
      return phrase.insert(index, ' ')
   else
      return phrase
   end
end

def is_english?(phrase, dict)
   words = phrase.join.split(' ')
   words.each { |word|
      return false if  !dict.include?(word)
   }

   return true
end

def random_try(devoweled, vowels)
   current_phrase = devoweled
   last_vowel_pos = 0
   i = 0

   loop {
      break if vowels.empty?

      current_phrase, last_vowel_pos =
         insert_vowel_rand(current_phrase, vowels.shift, last_vowel_pos)
   }

   return current_phrase
end

def main

   file = File.open("input1.txt", "r")
   dict = populate_dictionary(DICT_PATH)
   dvoweled = file.gets.chomp.split('')
   vowels = file.gets.chomp.split('')

   i = 0

   loop {
      generated_phrase = random_try(dvoweled, vowels)
      puts "#{i}   #{generated_phrase}"
      break if is_english?(generated_phrase, dict)
      i += 1
   }
end