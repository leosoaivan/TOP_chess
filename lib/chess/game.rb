class Game
  InputError = Class.new(StandardError)
  MoveError = Class.new(StandardError)
  attr_accessor :current_move, :board
  attr_reader :current_player, :player1, :player2
  
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = set_player_to_go_first
    @current_move = {start: nil, end: nil}
  end
  
  def move
    begin
      current_move[:start], current_move[:end] = get_move
      validate_input(current_move)
      convert_input
      #check for legal moves
    rescue InputError => error
      yield error.message if block_given?
      retry
    rescue MoveError => error
      yield error.message if block_given?
      retry
    end
  end
  
  def get_move
    puts "Enter your move motherfucker. Example (a1 to b2)"
    split_player_input(gets.chomp)
  end
  
  def parse_input(input)
    input.gsub(/\s+/, "")
  end
    
  def split_player_input(input)
    parse_input(input).downcase.split("to")
  end
    
  def validate_input(input)
    raise InputError, "Your input is not valid" unless valid_input?(input)
  end
  
  def valid_input?(input)
    input.all? do |key, value|
      /([a-h][1-8])/ =~ value \
                    && value.length == 2
    end
  end
  
  def convert_input
    current_move.each_pair do |key, value|
      current_move[key] = CoordinateConverter.convert_input(value)
    end
  end
  
  def legal_move?
    # Game ensures the start coordinate contains one of player's pieces
    raise MoveError, "The start square does not contain a piece" if empty_square?(current_move[:start])
    #* Game ensures the end coordinate DOES NOT contain player's pieces
    raise MoveError, "You are trying to move to a square that already contains one of your pieces" if already_occupied?(current_move[:end])
    #* Game ensures the end coordinate is within player's piece's moveset
    #* Game ensures the path is not blocked
    #* Game ensures that player is not left in check
  end
  
  def empty_square?(coordinates)
    board.square(*coordinates).nil?
  end
  
  def already_occupied?(coordinates)
    return false if empty_square?(*coordinates)
    board.square(*coordinates).colour == current_player.colour
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
    
    def piece_hash
      Pieces.to_hash.inject({}) do |hash, (piece_name, colour_hash) |
        hash.merge(PieceCreator.new(piece_name, colour_hash).create)
      end
    end

end