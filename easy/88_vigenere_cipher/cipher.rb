require 'pp'

def decrypt(ciphertext, key)
   puts ciphertext
   puts key
end

def encrypt(plaintext, key)
   alphabet = (a..z)
   # stretch key out to be size of plaintext
   key_stretched = (key * (plaintext.length / key.length + 1)
                  ).split('').first(plaintext.length)
   key_stretched.map { |char|
       
   }.join
end

def main
   plaintext = 'THECAKEISALIE'
   key = 'GLADOS'
   encrypt(plaintext, key)
end

if $0 == __FILE__
   main
end
