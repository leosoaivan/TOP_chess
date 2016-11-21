class Board
  attr_accessor :gameboard
  
  def initialize
    @gameboard = Array.new(8) { Array.new(8) }
  end

end