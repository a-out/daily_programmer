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

   def translate(lines)
      translated = []
      for i in 0..lines.size do
         new_string = "" 
         lines.map { |line|            
            if line.size > i
               
            end
         }

         translated << new_string
      end

      return translated.reverse
   end
  
end

include AsciiArchitect

def main
   strings = []
   'abcdefghij'.split('').map { |char|
      strings << line(char)
   }

   puts translate(strings)


end

if $0 == __FILE__
   main
end