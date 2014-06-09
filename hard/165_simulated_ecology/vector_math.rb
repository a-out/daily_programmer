module VectorMath

   def self.add_vec(v1, v2)
      return [v1[0] + v2[0], v1[1] + v2[1]]
   end

   def self.adjacent(vec, grid)
      directions = [1, 0, -1, 1, 0, -1].permutation(2).to_a.uniq
      directions.delete([0, 0])
      directions.map { |dir|
         grid[add_vec(vec, dir)]
      }.compact
   end

end