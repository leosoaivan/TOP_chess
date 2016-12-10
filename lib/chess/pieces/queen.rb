class Queen < Piece
  attr_reader :symbol
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = [
      [-1, -1], [-1, 1], [1, 1], [1, -1],
      [-1, 0], [0, 1], [1, 0], [0, -1]
    ]
  end

  private
  
    def set_symbol
      self.colour == :white ? "\u2655" : "\u265B"
    end
end