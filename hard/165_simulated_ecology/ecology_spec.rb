require 'rspec'
require_relative 'ecology.rb'
require 'pp'

describe 'create_forest' do 
   it 'creates a new forest of size x and y' do
      forest = Forest.new(10, 10)
      pp forest.grid
      forest.print
   end   
end