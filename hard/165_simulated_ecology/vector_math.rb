module VectorMath

   def self.add_vec(v1, v2)
      return [v1[0] - v2[0], v1[1] - v2[1]]
   end

   def self.adjacent(vec, grid, filter=nil)
      directions = [ [-1,0], [0,-1], [1,0], [0,1] ]
      adjacent = directions.map { |dir|
         add_pos(vec, dir)
      }
      if filter.nil?
         adjacent
      else
         select { |mod_pos|
            grid.keys.include?(mod_pos) &&
            filter.include?(grid[mod_pos])
         }
      end
   end

end