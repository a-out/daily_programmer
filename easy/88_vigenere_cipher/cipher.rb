require 'pp'

def decrypt(ciphertext, key)
   puts ciphertext
   puts key
end

def encrypt(plaintext, key)
   alphabet = ('a'..'z').to_a
   # stretch key out to be size of plaintext
   key_stretched = (key * (plaintext.length / key.length + 1)
                  ).split('').first(plaintext.length)
   
   letter_distances = key_stretched.map { |char|
      char.downcase.ord - 96 
   }
end

def main
   plaintext = 'THECAKEISALIE'
   key = 'GLADOS'
   pp encrypt(plaintext, key)
end

if $0 == __FILE__
   main
end
