require_relative 'vector_math'

class ForestInhabitant

   @@symbol = '.'

   def initialize(x, y)
      @x, @y = x, y
   end

   def move(x, y)
      @x, @y = x, y
   end

   def symbol
      @@symbol
   end

end

class Tree < ForestInhabitant
   @@symbols = { sapling: 's', tree: 'T', elder: 'E' }

   def initialize(x, y, maturity = :tree)
      super(x, y)
      @maturity = maturity
   end

   def symbol
      @@symbols[@maturity]
   end
end

class Bear < ForestInhabitant
   @@symbol = 'B'
end

class Lumberjack < ForestInhabitant
   @@symbol = 'L'
end

class Forest

   attr_accessor :grid

   def initialize(x, y)
      @x, @y = x, y
      @grid = generate
   end

   def generate()
      grid = Hash.new
      for y in 0..@y
         for x in 0..@x
            occupant = choose_random            
            grid[[x, y]] = if occupant.nil?
               nil
            else
               occupant.new(x, y)
            end
         end
      end

      grid
   end

   def print
      for y in 0..@y
         for x in 0..@x
            symbol = grid[[x, y]].nil? ? '.' : grid[[x, y]].symbol
            STDOUT.print "#{symbol} "
         end
         puts
      end
      puts
   end

   def choose_random
      case rand(100)
      when 0..2
         Bear
      when 3..12
         Lumberjack
      when 13..62
         Tree
      else
         nil
      end
   end

   def move(occupant, dest)
      @grid[dest] = occupant
      #occupant.move(dest[0], dest[1])
   end

   def step

   end

end

def main
end

if $0 == __FILE__
   main
end