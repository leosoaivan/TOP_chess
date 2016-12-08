class Knight < Piece
  attr_reader :symbol
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2658" : "\u265E"
    end
end