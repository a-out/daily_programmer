class PhoneNetworkGraph

   def initialize
      @nodes = {}
   end

   def add_connection(src, dest)
      if @nodes.include? src
         @nodes[src] << (dest)
      else
         @nodes[src] = [dest]
      end
   end

   def path_to(src, dest)

   end

   def can_reach(src, dest)
      @nodes[src].include? dest
   end

end

def main
   phone_network = PhoneNetworkGraph.new
   phone_network.add_connection('A', 'B')
end

if $0 == __FILE__
   main
end
