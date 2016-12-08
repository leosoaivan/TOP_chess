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
    board.add_piece(Pawn.new(:white), [6,0])
    board.add_piece(Pawn.new(:white), [6,1])
    board.add_piece(Pawn.new(:white), [6,2])
    board.add_piece(Pawn.new(:white), [6,3])
    board.add_piece(Pawn.new(:white), [6,4])
    board.add_piece(Pawn.new(:white), [6,5])
    board.add_piece(Pawn.new(:white), [6,6])
    board.add_piece(Pawn.new(:white), [6,7])
    board.add_piece(Pawn.new(:black), [1,0])
    board.add_piece(Pawn.new(:black), [1,1])
    board.add_piece(Pawn.new(:black), [1,2])
    board.add_piece(Pawn.new(:black), [1,3])
    board.add_piece(Pawn.new(:black), [1,4])
    board.add_piece(Pawn.new(:black), [1,5])
    board.add_piece(Pawn.new(:black), [1,6])
    board.add_piece(Pawn.new(:black), [1,7])
    board.add_piece(Rook.new(:white), [7,0])
    board.add_piece(Rook.new(:white), [7,7])
    board.add_piece(Knight.new(:white), [7,1])
    board.add_piece(Knight.new(:white), [7,6])
    board.add_piece(Bishop.new(:white), [7,2])
    board.add_piece(Bishop.new(:white), [7,5])
    board.add_piece(King.new(:white), [7,3])
    board.add_piece(Queen.new(:white), [7,4])
    board.add_piece(Rook.new(:black), [0,0])
    board.add_piece(Rook.new(:black), [0,7])
    board.add_piece(Knight.new(:black), [0,1])
    board.add_piece(Knight.new(:black), [0,6])
    board.add_piece(Bishop.new(:black), [0,2])
    board.add_piece(Bishop.new(:black), [0,5])
    board.add_piece(King.new(:black), [0,3])
    board.add_piece(Queen.new(:black), [0,4])
  end
  
  BLACK_PIECES = {
    pawn: [[1,0],[1,1][1,2],[1,3][1,4],[1,5],[1,6],[1,7]],
    castle: [[0,0],[0,7]],
    knight: [[0,1],[0,6]],
    rook: [[0,2],[0,5]],
    king: [0,3],
    queen: [0,4]
  }
  
  WHITE_PIECES = {
    pawn: [[6,0],[6,1][6,2],[6,3][6,4],[6,5],[6,6],[6,7]],
    castle: [[7,0],[7,7]],
    knight: [[7,1],[7,6]],
    rook: [[7,2],[7,5]],
    king: [7,3],
    queen: [7,4]
  }
  
  private
    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end
    
    def parse_input(input)
      input.gsub(/\s+/, "")
    end

end