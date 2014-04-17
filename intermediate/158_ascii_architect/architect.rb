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
      longest_line = lines.map { |l| l.size }.max

      # essentially rotates the shape 90 degrees clockwise,
      # and then mirrors it on the y axis
      for i in 0..longest_line
         new_line = ""
         lines.map { |line|
            padded_line = line.ljust(lines.size)
            new_line << padded_line[i]
         }

         translated << new_line unless new_line.size == 0
      end

      # reverse mirrors the shape on the x axis
      return translated.reverse
   end

end

include AsciiArchitect

def main
   parsed = parse(STDIN.readline)
   puts translate(parsed.map { |token|
      process_line(token)
   })
end

if $0 == __FILE__
   main
end