require 'pp'

TILE_DEFS = {
   '*' => :nest,
   '#' => :impassable,
   '+' => :unreliable,
   '-' => :reliable,
   'o' => :bunker
}

def find_tiles(type, map)
   map.select { |key, val|
      TILE_DEFS[val] == type
   }
end

def addVector (v1, v2)
   [v1[0] + v2[0], v1[1] + v2[1]]
end

def distVector (v1, v2)
   x = (v1[0] - v2[0]).abs
   y = (v1[1] - v2[1]).abs
   x * y
end

def adjacent(vector, map)
   modVectors = [1, 0, -1, 1, 0, -1].combination(2).to_a.uniq
   modVectors.map { |modVec|
      addVector(vector, modVec)
   }.select { |vec| map.keys.include?(vec) }
end

def print_map(map, size)
   for x in 0..size
      for y in 0..size
         STDOUT.print "#{map[[x, y]]} "
      end
         puts
   end
end

# find nearest tile of type in list of tiles
def find_nearest(x, y, type, tiles)
   tiles.to_a.select { |tile|
      TILE_DEFS[tile.last] == type
   }.sort { |v1, v2|
      distVector(v1.first, [x, y]) <=>
      distVector(v2.first, [x, y])
   }.first
end

def step(map)
   nests = find_tiles(:nest, map)

   # find vectors of all tiles adjacent to nests
   adjacent_to_nests = nests.map { |key, val|
      adjacent(key, map)
   }.flatten(1)

   # turn array of vectors into nested array
   new_nest_tiles = adjacent_to_nests.map { |adj_tile|
      [adj_tile, '*']
   }

   # turn vector array into a hash of nest tiles
   # and merge it with the previous map, updating it
   map.merge(Hash[new_nest_tiles])
end

def map_from_file(file)
   input = File.open(file, 'r')

   map_height, map_width = input.gets.chomp.split(' ')
   map = Hash.new
   strings = input.readlines.map(&:chomp)

   strings.each_with_index { |str, i|
      str.split('').each_with_index { |char, j|
         map[[i, j]] = char
      }
   }

   return map
end

if ($0 == __FILE__)
   map = map_from_file('example1')

   map_stepped = step(map)
   print_map(map_stepped, 6)

   pp find_nearest(3, 3, :nest, map_stepped)

end