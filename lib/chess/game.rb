class Game
  attr_accessor :current_move, :board
  attr_reader :current_player, :player1, :player2
  
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    #@current_player = set_player_to_go_first
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
  
  def setup_board
    piece_hash.each_pair do |position, piece|
      board.add_piece(piece, position)
    end
  end

  private

    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end
    
    def parse_input(input)
      input.gsub(/\s+/, "")
    end
    
    def piece_hash
      Pieces.to_hash.inject({}) do |hash, (piece_name, colour_hash) |
        hash.merge(PieceCreator.new(piece_name, colour_hash).create)
      end
    end

end