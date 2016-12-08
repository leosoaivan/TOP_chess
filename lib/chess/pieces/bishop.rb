class Bishop < Piece
  attr_reader :symbol
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2657" : "\u265D"
    end
end