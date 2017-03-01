class Player
  attr_accessor :in_check
  attr_reader :name, :colour
  
  def initialize(name, colour)
    @name = name
    @colour = colour
    @in_check = false
  end
  
  def checked(status)
    self.in_check = status
  end
end