class Bishop < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2657" : "\u265D"
    end
end