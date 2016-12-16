class Piece
  attr_reader :colour, :symbol, :move_set
  
  def initialize(colour)
    @colour = colour
  end
  
  def to_s
    self.symbol.encode('utf-8')
  end
end