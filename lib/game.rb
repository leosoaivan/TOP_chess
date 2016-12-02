class Game
  attr_reader :current_player, :player1, :player2
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = set_player_to_go_first
    @co_ordinates = []
  end
  
  BOARD_MAP = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }
  
  def valid_input?(input)
    /([a-h][1-8]){2}/ =~ input.downcase  \
                        && input.length == 4 ? true : false
  end

  def split_player_input(input)
    [input[0,2], input[2,2]]
  end
  
  def parse_input(input)
    input.gsub(/\s+/, "")
  end
  
  def convert_input(ary_input)
    ary_input.map! do |elem|
      elem[0] = BOARD_MAP["#{elem[0]}"]
      elem[1] = (elem[1].to_i - 8).abs
      elem = [elem[1], elem[0]]
    end
  end

  def change_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
  
  private
    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end

end