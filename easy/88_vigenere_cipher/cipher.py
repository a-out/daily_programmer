from pprint import pprint
import itertools

def encode(plaintext, key):

   # zip lists into tuple, stretching smaller list to match upper
   zipped = [(i,j) for i, j in itertools.izip(plaintext, itertools.cycle(key))]
   
   # add the two letter values (from 0 to 26), and conver back to char
   enc = lambda x, y: chr( ((x + y) % 26) + 97 )

   # run enc lambda for each letter value, join back into string
   return ''.join([enc(ord(x) - 97, ord(y) - 97) for x, y in zipped])
      

if __name__ == '__main__':
   plaintext = [x.lower() for x in 'THECAKEISALIE']
   key =       [x.lower() for x in 'GLADOS']

   pprint(encode(plaintext, key))
   