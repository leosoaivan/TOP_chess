class Game
  attr_reader :current_player, :player1, :player2, :co_ordinates, :current_move
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = set_player_to_go_first
    @current_move = nil
  end
  
  def valid_input?(input)
    input.all? do |elem|
      /([a-h][1-8])/ =~ elem \
                        && elem.length == 2
    end
  end

  def split_player_input(input)
    self.current_move = parse_input(input).downcase.split("to")
  end

  def change_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
  
  private
    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end
    
    def parse_input(input)
      input.gsub(/\s+/, "")
    end

end