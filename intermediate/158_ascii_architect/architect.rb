require 'pp'
module AsciiArchitect

   # converts a letter a-j to the proper line
   def line(letter)
      if (letter.size != 1) || (!letter.is_a? String) ||
         (!'abcdefghij'.include? letter)
         raise ArgumentError, "not a letter a-j", caller
      end

      letter_value = letter.ord - 96
      '++--***...'.split('').slice(0, letter_value).join
   end

   def parse(input_str)
      split = input_str.scan(/[1-9]*[a-j]/)
      parsed = []

      split.map { |token|
         if token.size > 1
            { num: token[0].to_i, letter: token[1] }
         else
            { letter: token[0], num: nil }
         end
      }
   end

   def process_line(token)
      if !token[:num].nil?
         " " * token[:num] + line(token[:letter])
      else
         line(token[:letter])
      end
   end

   def translate(lines)
      translated = []

      # skim off a character from each line,
      # essentially flipping the shape by 90 degrees
      for i in 0..lines.size do
         new_string = ""
         lines.map { |line|
            if line.size > i
               new_string << line[i]
            end
         }

         translated << new_string unless new_string.size == 0
      end

      # pad the left side of the lines with zeroes,
      # essentially pushing the shape to the right side
      translated.reverse.map { |line|
         line.rjust(translated.size)
      }
   end

end

include AsciiArchitect

def main
   strings = []
   'abcdefghij'.split('').map { |char|
      strings << line(char)
   }

   # pp translate(strings)
   parsed = parse("j3f3e")
   pp parsed

   puts translate(parsed.map { |token|
      process_line(token)
   })
end

if $0 == __FILE__
   main
end