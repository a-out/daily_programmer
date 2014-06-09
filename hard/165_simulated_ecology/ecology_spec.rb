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
         #pp @forest.grid
         @forest.print
      end
   end

   # describe 'Forest#step' do
   #    it 'simulates one month of forest activity' do
   #       @forest.step
   #    end
   # end

   describe 'Forest#adjacent' do
      it 'returns all spaces adjacent to pos, with an optional filter' do
         all_adjacent = @forest.adjacent([1, 1])
         dirt_adjacent = @forest.adjacent([1, 1], Dirt)
         tree_adjacent = @forest.adjacent([1, 1], Tree)
         sapling_adjacent = @forest.adjacent([1, 1], Tree, :sapling)

         all_adjacent.size.should eq 8
         dirt_adjacent.size.should eq 3
         tree_adjacent.size.should eq 3
         sapling_adjacent.size.should eq 1
      end
   end

   describe 'Forest#move' do
      it 'moves a forest occupant to a new space' do
         sapling = @forest.get([0, 0])
         @forest.move(sapling, [0, 1])

         sapling.pos.should eq [0, 1]
         @forest.get([0, 1]).should eq sapling
      end
   end

   describe 'Forest#get_all' do
      it 'gets each inhabitant that matches type' do
         trees = @forest.get_all(Tree)
         saplings = @forest.get_all(Tree, :sapling)
         lumberjacks = @forest.get_all(Lumberjack)
         bears = @forest.get_all(Bear)

         trees.size.should eq 56
         saplings.size.should eq 1
         lumberjacks.size.should eq 10
         bears.size.should eq 6
      end
   end

end