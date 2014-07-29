def disemvowel(input_str, vowels):
    vowels = [v for v in input_str if (v in vowels)]
    disemvoweled = [c for c in input_str if (c not in vowels)]

    return (''.join(disemvoweled), ''.join(vowels))

if __name__ == '__main__':
    INPUT_TEXT = open('input1.txt').read()
    vowels = list('aeiou')

    output = disemvowel(INPUT_TEXT, vowels)
    print(output[0], output[1], sep="")
