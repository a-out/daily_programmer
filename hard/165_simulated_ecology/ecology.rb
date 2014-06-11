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

   def step(forest)
      wander_distance = (0..5).to_a.sample
      wander(forest, wander_distance)
   end

   def wander(forest, distance)
      distance.times {
         free_spaces = forest.adjacent(@pos)
         new_space = free_spaces.sample

         if new_space.class == Lumberjack
            maw(new_space, forest)
            break
         end

         forest.move(self, new_space.pos)
      }
   end

   def maw(lumberjack, forest)
      forest.remove(lumberjack)
      forest.event(:lumberjack_mawed)
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
      if space.class == Tree && space.maturity == :tree
         forest.event(:tree_chopped)
         space.lumber
      elsif space.class == Tree && space.maturity == :elder
         forest.event(:elder_tree_chopped)
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
      :tree_chopped,
      :elder_tree_chopped,
      :lumberjack_mawed
   ]

   attr_accessor :grid

   def initialize(x, y)
      @x, @y = x, y
      @grid = generate
      @month = 0
      @year = 0
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
         grid[[5, 5]] = Tree.new([5, 5], :elder)
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
      @grid[pos] = occupant
   end

   def add_at_random_pos(occupant_type)
      new_pos = get_all(Dirt).sample.pos
      set(new_pos, occupant_type.new(new_pos))
   end

   def remove(occupant)
      @grid[occupant.pos] = Dirt.new(occupant.pos)
   end

   def event(event_type)
      if @@forest_events.include?(event_type)
         @events[@month] << event_type
      else
         raise ArgumentError, "Unrecognized event name #{event_type}", caller
      end 
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
         @events[@month] = []         

         trees = get_all(Tree)
         trees.each { |tree|
            tree.step(self)
         }

         lumberjacks = get_all(Lumberjack)
         lumberjacks.each { |lj|
            lj.step(self)
         }

         bears = get_all(Bear)
         bears.each { |bear|
            bear.step(self)
         }

         @month += 1

         if @month % 12 == 0 
            year_passed
         end
      }
   end

   def year_passed
      this_years_months = (@year * 12)..( (@year + 1) * 12 - 1)
      this_years_stats = @events.select { |month, events| this_years_months.include?(month) }

      stats = this_years_stats.flatten(2).select { |x| x.class == Symbol }
      mawing_incidents = stats.count(:lumberjack_mawed)

      

      if mawing_incidents == 0
         add_at_random_pos(Bear)
      else
         trapped_bear = get_all(Bear).sample
         remove(trapped_bear)
      end

      pp stats

      lumber_collected = stats.map { |event| 
         if event == :tree_chopped
            1
         elsif event == :elder_tree_chopped
            2
         else
            0
         end
      }.reduce(0, :+)

      num_lumberjacks = get_all(Lumberjack).size

      # add lumberjack if yearly lumber production exceeds workforce
      # remove lumberjack if workforce exceeds yearly lumber production
      if lumber_collected > num_lumberjacks
         add_at_random_pos(Lumberjack)
      elsif lumber_collected < num_lumberjacks
         remove(get_all(Lumberjack).sample)
      end

      @year += 1
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
