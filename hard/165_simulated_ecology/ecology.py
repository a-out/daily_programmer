from pprint import pprint
from itertools import product
import random

FOREST_SIZE = 10

class Forest:

   def __init__(self, size):
      self.size = size
      self.generate()

   def generate(self):
      coords = [(x, y) for x in range(self.size) for y in range(self.size)]
      world = {}

      # default empty world
      for pos in product(range(FOREST_SIZE), range(FOREST_SIZE)):
         world[pos] = None

      random.shuffle(coords)

      # todo: don't hardcode these slices
      for c in coords[:50]:
         world[c] = Tree(self, c)
      for c in coords[50:60]:
         world[c] = Lumberjack(self, c)
      for c in coords[60:62]:
         world[c] = Bear(self, c)

      self.grid = world

   def step(self):


   def neighbors(self, pos):
      x, y = pos
      p_x = [a for a in range(x - 1, x + 2)]
      p_y = [b for b in range(y - 1, y + 2)]
      neighbor_coords = filter(lambda p : p != pos,
         product(p_x, p_y)
      )
      return [self.grid[x] for x in neighbor_coords if x is not None]

   def draw(self):
      for x in range(self.size):
         for y in range(self.size):
            entity = self.grid.get((x, y))
            char = entity.char if entity else '.'
            print("{0}  ".format(char), end="", flush=True)

         print("")

   def place(self, coord, entity_type):
      self.grid[coord] = entity_type(self, coord)



class Tree:
   def __init__(self, forest, pos, type='T'):
      self.forest = forest
      self.pos = pos
      self.char = type
      self.age = 0

   def step(self):


      # age tree
      self.age += 1
      if self.age == 12 and self.char == 'S':
         self.age = 0
         self.char = 'T'
      elif self.age == 120 and self.char == 'T':
         self.age = 0
         self.char = 'E'


class Bear:
   def __init__(self, forest, pos):
      self.forest = forest
      self.pos = pos
      self.char = 'B'


class Lumberjack:
   def __init__(self, forest, pos):
      self.forest = forest
      self.pos = pos
      self.char = 'L'

 
# -------------------------------------

forest = Forest(FOREST_SIZE)
forest.place((0, 0), Bear)
forest.draw()