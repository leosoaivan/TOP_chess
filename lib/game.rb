class Game
  attr_reader :current_player, :player1, :player2
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = set_player_to_go_first
  end
  
  def split_player_input(input)
    [input[0,2], input[2,2]]
  end
  
  def change_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
  
  private
    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end
    "Hello"
end