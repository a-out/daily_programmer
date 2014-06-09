require 'rspec'
require_relative 'ecology.rb'
require 'pp'

describe 'Forest' do

   before :each do
      test_file_path = 'hard/165_simulated_ecology/test_forest'
      @forest = Marshal.load(File.open(test_file_path).read)
   end

   describe 'Forest#new' do
      it 'creates a new forest of size x and y' do
         @forest.print
      end
   end

   describe 'Forest#step' do
      it 'simulates one month of forest activity' do
         @forest.step
      end
   end

   describe 'Forest#adjacent' do
      it 'returns all spaces adjacent to pos, with an optional filter' do
         @forest.adjacent(1, 1)
      end
   end

end