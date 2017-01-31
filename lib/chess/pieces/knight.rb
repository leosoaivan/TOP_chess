class Knight < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  def valid_move?(start, finish, board)
    knight_coordinates(start).any? { |coordinate| coordinate == finish } \
                  && piece_colours_not_match?(finish, board)
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2658" : "\u265E"
    end
    
    def knight_coordinates(coordinates)
      parse_knight_moves(knight_moves.map do |cords|
        coordinates.zip(cords).map! {|x,y| x - y }
      end)
    end
    
    def knight_moves
      [[-2, 1], [-2, -1], [-1, 2], [-1, -2],[1, -2], [1, 2], [2, 1], [2, -1]]
    end
    
    def parse_knight_moves(moves_array)
      moves_array.delete_if {|x, y| x < 0 || x > 7 || y < 0 || y > 7  }
    end
    
    def piece_colours_not_match?(finish, board)
      board.square(*finish).colour != self.colour
    end
end