require_relative '../reemvoweler'

INFILE1 = File.expand_path("../../input1.txt", __FILE__)

describe "Reemvoweler" do 

   describe "random_try" do
      it "tries to insert vowels(2nd param) into devoweled str(1st param) at random" do
         devoweled = "wwllfndffthstrds".split('')
         vowels = "eieoeaeoi".split('')
         generated = random_try(devoweled, vowels)

         # ensure that parameters aren't altered
         devoweled.should eq "wwllfndffthstrds".split('')
         vowels.should eq "eieoeaeoi".split('')

         puts "finished random try"
      end
   end

   describe "smallTest1" do
      it "tests string wwllfndffthstrds" do
         main(File.open(INFILE1, "r"), 3, 10)

         puts "finished small test"
      end
   end

   describe "randTest" do 
      it "tests most effective vowel rand distribution" do
         success_rates = Hash.new

         for i in 0..8
            success_rates[i] = main(File.open(INFILE1, "r"), i, 1000)
         end

         success_rates.sort_by{|key, val| val}.each { |key, val|
            puts "[#{key}]   #{val}"
         }
      end
   end

end