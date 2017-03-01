require_relative 'piece'

class Rook < Piece
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2656" : "\u265C"
    end
end