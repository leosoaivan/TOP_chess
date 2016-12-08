class Game
  attr_accessor :current_move, :board
  attr_reader :current_player, :player1, :player2
  
  PIECES = {
    Pawn: {
      white: [[6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7]],
      black: [[1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7]]
    },
    Rook: {
      white: [[7,0],[7,7]],
      black: [[0,0],[0,7]]
    },
    Knight: {
      white: [[7,1],[7,6]],
      black: [[0,1],[0,6]]
    },
    Bishop: {
      white: [[7,2],[7,5]],
      black: [[0,2],[0,5]]
    },
    King: {
      white: [[7,3]],
      black: [[0,3]]
    },
    Queen: {
      white: [[7,4]],
      black: [[0,4]]
    }
  }
  
  def initialize(board, player1, player2)
    @board = board
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
      PIECES.inject({}) do |hash, (piece_name, colour_hash) |
        hash.merge(PieceCreator.new(piece_name, colour_hash).create)
      end
    end

end