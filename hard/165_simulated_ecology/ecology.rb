require_relative 'vector_math'

class ForestInhabitant
   attr_accessor :pos

   def initialize(pos)
      @pos = pos
   end

   def move(new_pos)
      @pos = new_pos
   end

   def random(percent)
      rand(100) < percent
   end
end

class Dirt < ForestInhabitant
   def symbol
      '.'
   end
end

class Tree < ForestInhabitant
   @@symbols = { sapling: 's', tree: 'T', elder: 'E' }
   attr_accessor :age, :maturity

   def initialize(pos, maturity = :tree)
      super(pos)
      @maturity = maturity
      @age = 0
   end

   def symbol
      @@symbols[@maturity]
   end

   def lumber
      case @maturity
      when :tree
         1
      when :elder
         2
      else
         0
      end
   end

   def step(forest)
      age

      # 10% chance for tree to spawn a sapling
      # 10% chance for an elder tree
      if @maturity == :tree && random(10) ||
         @maturity == :elder && random(20)

         # get all free adjacent spaces
         empty_adjacent = forest.adjacent(@pos, Dirt)         

         # only create sapling if we have a free adjacent space
         if empty_adjacent.size > 0
            pos = empty_adjacent.sample.pos
            forest.set(pos, Tree.new(pos, :sapling))
            forest.event(:sapling_planted)
         end

      end
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
   def symbol
      'B'
   end
end

class Lumberjack < ForestInhabitant

   def initialize(pos)
      super(pos)
      @lumber = 0
   end

   def symbol
      'L'
   end

   def step(forest)
      wander_distance = (0..3).to_a.sample
      wander(forest, wander_distance)

   end

   def wander(forest, distance)
      distance.times {
         free_spaces = forest.adjacent(@pos).select { |occupant|
            occupant.class != Bear
         }

         if free_spaces.size > 0
            new_space = free_spaces.sample

            # chop down any mature trees we come across
            lumber_chopped = try_chop(new_space, forest)
            forest.move(self, new_space.pos)

            # stop moving for the month if we chopped down a tree
            if lumber_chopped > 0
               @lumber += lumber_chopped
               break
            end
         end         
      }
   end

   def try_chop(space, forest)
      if space.class == Tree && [:tree, :elder].include?(space.maturity)
         forest.event(:tree_chopped)
         space.lumber
      else
         0
      end
   end
end

class Forest

   @@forest_events = [
      :sapling_to_tree,
      :tree_to_elder,
      :sapling_planted,
      :tree_chopped
   ]

   attr_accessor :grid

   def initialize(x, y)
      @x, @y = x, y
      @grid = generate
      @month = 0
      @events = {}
   end

   def generate()
      grid = Hash.new
      for y in 0..@y
         for x in 0..@x
            occupant = choose_random
            grid[[x, y]] = occupant.new([x, y])
         end
         grid[[0, 0]] = Tree.new([0, 0], :sapling)
      end

      grid
   end

   def print
      for y in 0..@y
         for x in 0..@x
            symbol = @grid[[x, y]].symbol       
            STDOUT.print "#{symbol} "
         end
         puts
      end
      puts
   end

   def set(pos, occupant)
      #puts "setting #{pos} to #{occupant.class}"
      @grid[pos] = occupant
   end

   def remove(pos)
      @grid[pos] = Dirt.new(pos)
   end

   def event(event_type)
      #puts "EVENT: #{event_type.to_s}"
      @events[@month] << event_type unless 
         !@@forest_events.include?(event_type)
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
         Dirt
      end
   end

   def move(occupant, dest)
      initial_pos = occupant.pos
      #pp initial_pos
      occupant.move(dest)
      @grid.merge!({
         initial_pos => Dirt.new(initial_pos),
         dest => occupant
         })
   end

   def get(pos)
      @grid[pos]
   end

   def get_all(type, maturity = nil)
      @grid.values.select { |val|
         if type == Tree
            if maturity.nil?
               val.class == Tree
            else
               val.class == Tree && val.maturity == maturity
            end
         else   
            val.class == type
         end
      }
   end

   def step(months = 1)
      months.times {
         @month += 1
         @events[@month] = []
         trees = get_all(Tree)
         trees.each { |tree|
            tree.step(self)
         }

         lumberjacks = get_all(Lumberjack)
         lumberjacks.each { |lj|
            lj.step(self)
         }
      }
   end

   def adjacent(pos, type = nil, maturity = nil)
      adj = VectorMath.adjacent(pos, @grid)
      if type.nil?
         adj
      else
         adj.select { |occupant|
            if type == Tree && !maturity.nil?
               occupant.class == type && occupant.maturity == maturity
            else
               occupant.class == type
            end
         }
      end
   end

end

def main
end

if $0 == __FILE__
   main
end
