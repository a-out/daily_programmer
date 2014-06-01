require 'pp'

input = File.open('example1', 'r')

TILES = {
   '*' => :nest,
   '#' => :impassable,
   '+' => :unreliable,
   '-' => :reliable,
   'o' => :bunker
}

def find_tiles(type, map)
   map.select { |key, val|
      val == type
   }
end

def addVector (v1, v2)
   [v1[0] + v2[0], v1[1] + v2[1]]
end

def adjacent(vector, map)
   modVectors = [1, 0, -1, 1, 0, -1].combination(2).to_a.uniq
   modVectors.map { |modVec| 
      addVector(vector, modVec)
   }.select { |vec| map.keys.include?(vec)}
end

def step(map)

end

map_height, map_width = input.gets.chomp.split(' ')
map = Hash.new
strings = input.readlines.map(&:chomp)

strings.each_with_index { |str, i| 
   str.split('').each_with_index { |char, j|
      map[[i, j]] = TILES[char]
   }
}

#pp find_tiles(:unreliable, map)
pp map
pp adjacent([5, 5], map)
#pp adjacent([5, 5], map)