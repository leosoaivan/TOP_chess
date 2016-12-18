class Pawn < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = []
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2659" : "\u265F"
    end
end