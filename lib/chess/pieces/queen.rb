class Queen < Piece
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [[-1, -1], [-1, 1], [1, 1], [1, -1],[-1, 0], [0, 1], [1, 0], [0, -1]]
  end
  
  def generate_moves
    clear_moves
    create_moves
  end
  
  def valid_move?(coordinate)
    self.moves.include?(coordinate)
  end


  private
  
    def set_symbol
      self.colour == :white ? "\u2655" : "\u265B"
    end
    
    def clear_moves
      @moves = nil
    end
    
    def valid_node?(node, board)
      return false if invalid_node?(node)
      unless board.square(*node).nil?
        return false unless different_colour_piece?(node, board)
      end
      true
    end
    
    def invalid_node?(node)
      node.any? { |num| num < 0 || num > 7 }
    end
end