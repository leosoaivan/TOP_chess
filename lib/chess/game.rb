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
      legal_move?
      board.move_piece(current_move[:start], current_move[:end])
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
    # Game ensures the start coordinate is not empty
    raise MoveError, "Your start co-ordinate is empty" if empty_square?(current_move[:start])
    
    # Ensures the start coordinate contains a piece the same colour as the player
    raise MoveError, "Your start co-ordinate contains a piece that isn't yours" unless already_occupied?(current_move[:start])
    
    #* Game ensures the end coordinate DOES NOT contain player's pieces
    unless empty_square?(current_move[:end])
      raise MoveError, "You are trying to move to a square that already contains one of your pieces" if already_occupied?(current_move[:end])
    end
    
    #* Game ensures the end coordinate is within player's piece's moveset
    #* Game ensures the path is not blocked
    raise MoveError, "You cannot move to that square" unless board.square(*current_move[:start]).valid_move?(current_move[:start], current_move[:end], board)
    
    #* Game ensures that player is not left in check
    temp_board = Marshal.load(Marshal.dump(board))
    temp_board.move_piece(current_move[:start], current_move[:end])
    king = board.square(*board.get_coordinate(King, current_player.colour))
    raise MoveError, "That move leaves your King in check" if king.in_check?(
              board.get_coordinate(King, current_player.colour) , temp_board)
  end
  
  def empty_square?(coordinates)
    board.square(*coordinates).nil?
  end
  
  def already_occupied?(coordinates)
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