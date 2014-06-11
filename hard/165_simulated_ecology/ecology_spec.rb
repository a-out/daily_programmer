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
         #File.open('test_forest', 'w').write(Marshal.dump(@forest))
      end
   end

   describe 'Forest#step' do
      it 'simulates one month of forest activity' do
         pre_step_sapling_count = @forest.get_all(Tree, :sapling).size
         @forest.step

         expect(@forest.get_all(Tree, :sapling).size).to be > pre_step_sapling_count
         puts
         @forest.print
      end
   end

   describe 'Forest#long_step' do
      it 'steps for a while' do
         @forest.step(12)
         @forest.print
      end
   end

   describe 'Forest#adjacent' do
      it 'returns all spaces adjacent to pos, with an optional filter' do
         all_adjacent = @forest.adjacent([1, 1])
         dirt_adjacent = @forest.adjacent([1, 1], Dirt)
         tree_adjacent = @forest.adjacent([1, 1], Tree)
         sapling_adjacent = @forest.adjacent([1, 1], Tree, :sapling)

         expect(all_adjacent.size).to eq 8
         expect(dirt_adjacent.size).to eq 1
         expect(tree_adjacent.size).to eq 5
         expect(sapling_adjacent.size).to eq 1
      end
   end

   describe 'Forest#move' do
      it 'moves a forest occupant to a new space' do
         sapling = @forest.get([0, 0])
         @forest.move(sapling, [0, 1])

         sapling.pos.should eq [0, 1]
         expect(@forest.get([0, 1])).to eq sapling
      end
   end

   describe 'Forest#get_all' do
      it 'gets each inhabitant that matches type' do
         trees = @forest.get_all(Tree)
         saplings = @forest.get_all(Tree, :sapling)
         lumberjacks = @forest.get_all(Lumberjack)
         bears = @forest.get_all(Bear)

         expect(trees.size).to eq 68
         expect(saplings.size).to eq 1
         expect(lumberjacks.size).to eq 14
         expect(bears.size).to eq 5
      end
   end

end