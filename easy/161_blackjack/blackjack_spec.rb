require_relative './blackjack.rb'
require 'pp'

describe 'Deck' do 

   before :each do 
      @deck = Deck.new
   end

   describe 'initialize' do
      it 'creates a new (unshuffled) deck of cards' do
         @deck.cards.size.should eq 52
      end
   end

   describe 'shuffle' do
      it 'shuffles the deck of cards' do
         original_deck = @deck.dup
      end
   end

   describe 'draw' do
      it 'deals out the top card of the deck' do
         shuffled = @deck.shuffle
         card1 = shuffled.draw
         card2 = shuffled.draw

         card1.should_not eq card2
      end
   end
   
end