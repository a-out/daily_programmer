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

   def random(percent)
      rand(100) < percent
   end
end

class Tree < ForestInhabitant
   @@symbols = { sapling: 's', tree: 'T', elder: 'E' }
   attr_accessor :age, :maturity

   def initialize(x, y, maturity = :tree)
      super(x, y)
      @maturity = maturity
      @age = 0
   end

   def symbol
      @@symbols[@maturity]
   end

   def step(forest)
      age
   end

   def age
      @age += 1
      if @maturity == :sapling
         # grow into a tree
         if @age == 12
            @maturity = :tree
            @age = 0
         end
      elsif @maturity == :tree
         # grow into an elder tree
         if @age == 120
            puts "tree matured into an elder tree"
            @maturity = :elder_tree
            @age = 0
         end
      end
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

         grid[[0, 0]] = Tree.new(0, 0, :sapling)
         grid
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

   def get_all(inhabitant)
      @grid.values.select { |val|
         val.class == inhabitant
      }
   end

   def step(months = 1)
      months.times {
         trees = get_all(Tree)
         trees.each { |tree|
            tree.step(@grid)
         }
      }
   end

   def adjacent(pos, type = nil, maturity = nil)
      VectorMath.adjacent(pos, @grid)
      # if type.nil?
      #    adj
      # else
      #    adj.select { |occupant|
      #       if type == Tree && !maturity.nil?
      #          occupant.class == type && occupant.maturity == maturity
      #       else
      #          occupant.class == type
      #       end
      #    }
      # end
   end

end

def main
end

if $0 == __FILE__
   main
end