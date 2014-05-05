class Card

   def initialize(suit, type)
      @suit, @type = suit, type
   end

   def to_s
      return ""
   end

end

class Deck

   attr_accessor :cards

   SUITS = [:diamonds, :spades, :clubs, :hearts]
   FACE_CARDS = {jack: 11, queen: 12, king: 13, ace: 1}

   def initialize
      @cards = []

      SUITS.map { |suit|
         for n in 2..10
            @cards = @cards.push(Card.new(suit, n))
         end

         FACE_CARDS.keys.map { |face|
            @cards = @cards.push(Card.new(suit, FACE_CARDS[face]))
         }
      }
   end

   def shuffle
      @cards = @cards.shuffle
      return self
   end

   def draw
      return @cards.pop
   end
end

def main
   deck = Deck.new
end

