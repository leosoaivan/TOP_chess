require_relative 'piece'

class Knight < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [[-2, 1], [-2, -1], [-1, 2], [-1, -2],[1, -2], [1, 2], [2, 1], [2, -1]]
  end

  private
  
    def set_symbol
      self.colour == :white ? "\u2658" : "\u265E"
    end
    
    def add_coordinates(node, cord, start, board)
      node = update_node(node, cord)
      self.moves << node if valid_node?(node, board)
    end
end