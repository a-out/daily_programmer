import sys
from pprint import pprint

if len(sys.argv) < 2:
   print("Requires one argument: ISBN.")
   sys.exit()

def valid_isbn(isbn):
   reversed_digits = list(reversed([int(x) for x in isbn if x != '-']))

   if (len(reversed_digits) < 10):
      return False

   digits_sum = sum([ reversed_digits[i] * (i + 1) for i in range(len(reversed_digits)) ])
   return (digits_sum % 11) == 0

print(valid_isbn(sys.argv[1]))