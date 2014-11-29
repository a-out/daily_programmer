require 'pp'

def sub_words(word, dict_words)
   subwords = []
   for subword_len in 1..(word.length - 2)
      pos = 0

      loop do
         subwords.push(word[pos..pos + subword_len])
         pos += 1
         break if (pos + subword_len) >= word.length
      end
   end

   subwords
end

def is_word?(word, word_list)
   word_list.include?(word)
end

# -----------------------

word = ARGV[0]

dict = File.open('../../files/enable1.txt', 'r').readlines.map { |l|
   l.chomp
}

words = sub_words(word, dict).select do |w|
   is_word?(w, dict)
end

pp words
