require 'pp'

def reorder(words, alphabet)
	words.sort { |a, b|
		word_value(a, alphabet) <=> word_value(b, alphabet)
	}
end

def word_value(word, alphabet)
	letters = word.split('')
	letters.inject(0) { |sum, n|
		sum + (alphabet.index(n) * (letters.size - letters.index(n)) )
	}
end

input = File.open('example1', 'r')
num_words = input.gets(' ').to_i
alphabet = input.gets.split('')
words = input.readlines.map { |line| line.chomp }
pp reorder(words, alphabet)