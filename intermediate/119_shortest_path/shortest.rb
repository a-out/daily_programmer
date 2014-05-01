require 'pp'

def main
   file = File.open('sample_input', 'r')
   input = file.readlines.map { |line| line.chomp }

end

if $0 == __FILE__
   main
end
