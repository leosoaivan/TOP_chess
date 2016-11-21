class Board
  attr_accessor :gameboard
  
  def initialize
    @gameboard = Array.new(8) { Array.new(8) }
  end
  
  def length
    @gameboard.length
  end
  
  def [](arg)
    @gameboard[arg]
  end

end