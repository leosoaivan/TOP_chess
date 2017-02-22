class King < Piece
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [[-1, -1], [-1, 1], [1, 1], [1, -1], [-1, 0], [0, 1], [1, 0], [0, -1]]
  end
  
  def in_check?(coordinate, board)
    king_coordinates = board.get_coordinates(self)
    opposite_colour_piece_array(board).each do |piece|
      return true if piece.moves.include?(king_coordinates)
    end
    false
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2654" : "\u265A"
    end
    
    def add_coordinates(node, cord, start, board)
      self.moves << update_node(node, cord) if valid_node?(node, board)
    end
    
    def valid_node?(node, board)
      return false if invalid_node?(node) || move_in_check?(node, board) || same_colour(node, board)
      true
    end
    
    def move_in_check?(node, board)
      opposite_colour_piece_array(board).each do |piece|
        return false if piece.moves.include?(node)
      end
      true
    end
    
    def opposite_colour_piece_array(board)
      self.colour == :white ? board.black_pieces : board.white_pieces
    end
end