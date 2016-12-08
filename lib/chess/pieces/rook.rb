class Rook < Piece
  attr_reader :symbol
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2656" : "\u265C"
    end
end