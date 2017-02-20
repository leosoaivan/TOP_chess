require_relative 'move_array'

class Piece
  include MoveArray
  attr_accessor :moves
  attr_reader :colour, :symbol, :move_set
  
  def initialize(colour)
    @colour = colour
  end
  
  def to_s
    self.symbol.encode('utf-8')
  end
  
  def create_moves(start, board)
    self.move_set.each do |cord|
      next_node = start
      add_coordiantes(next_node, cord, start, board)
    end
  end
  
  private
    def update_node(next_node, cord)
      next_node.zip(cord).map {|x,y| x - y }
    end
    
    def different_colour_piece?(node, board)
      board.square(*node).colour != self.colour
    end
    
    def add_coordinates(node, cord, start, board)
      while valid_node?(node, board) do
        self.moves << node unless node == start
        return if different_colour_piece?(node, board)
        node = update_node(node, cord)
      end
    end
end