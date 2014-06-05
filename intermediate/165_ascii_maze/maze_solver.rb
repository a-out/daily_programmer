def print_grid(grid, size_x, size_y)
   for y in 0..size_y
      for x in 0..size_x
         STDOUT.print grid[[x,y]]
      end

      puts
   end
end

def add_pos(v1, v2)
   [v1[0] + v2[0], v1[1] + v2[1]]
end

def walkable_adjacent(pos, grid)
   directions = [ [-1,0], [0,-1], [1,0], [0,1] ]
   directions.map { |dir|
      add_pos(pos, dir)
   }.select { |mod_pos|
      # only return walkable tiles within the confines of the maze
      grid.keys.include?(mod_pos) &&
      [' ', 'E'].include?(grid[mod_pos])}
end

# try to solve the maze. will modify grid in-place!
def solve(pos, grid)
   current_tile = grid[pos]

   # see if we're standing on the final tile
   if current_tile == 'E'
      return true
   end

   grid[pos] = '*' unless current_tile == 'S'

   walkable_adjacent(pos, grid).each { |adjacent|
      # solved. back out
      if solve(adjacent, grid)
         return true 
      end
   }

   # dead end. delete our path
   grid[pos] = ' '
   return false
end

maze_file = File.open('maze4', 'r')
size_x, size_y = maze_file.gets.split(' ').map(&:to_i)
grid = Hash.new

# store entire maze as a hash ([x,y] => 'c')
for y in 0..(size_y - 1)
   line = maze_file.gets.chomp
   for x in 0..(size_x - 1)
      grid[[x,y]] = line[x]
   end
end

start_pos = grid.to_a.select { |tile|
   tile.last == 'S'
}.first.first

print_grid(grid, size_x, size_y)
solve(start_pos, grid)
print_grid(grid, size_x, size_y)