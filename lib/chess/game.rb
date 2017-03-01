class Game
  InputError = Class.new(StandardError)
  MoveError = Class.new(StandardError)
  attr_accessor :current_move, :board, :white_king, :black_king, :current_player
  attr_reader :player1, :player2
  
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = set_player_to_go_first
    @current_move = {start: nil, end: nil}
    @white_king = nil
    @black_king = nil
  end
  
  def move
    begin
      current_move[:start], current_move[:end] = get_move
      validate_input(current_move)
      convert_input
      legal_move?
      board.move_piece(current_move[:start], current_move[:end])
      confirm_piece_moved
    rescue InputError => error
      yield error.message if block_given?
      retry
    rescue MoveError => error
      yield error.message if block_given?
      retry
    end
  end
  
  def get_move
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
      raise MoveError, "You cannot move to a square that contains a King" if king_occupied?(current_move[:end])
    end
    
    #* Game ensures the end coordinate is within player's piece's moveset
    #* Game ensures the path is not blocked
    raise MoveError, "The selected piece cannot move to your chosen square" unless board.square(*current_move[:start]).valid_move?(current_move[:end])
    
    #* Game ensures that player is not left in check once they move
    temp_board = create_temp_board
    temp_board.move_piece(current_move[:start], current_move[:end])
    temp_board.populate_piece_arrays
    temp_board.update_moves
    king = get_temp_king(temp_board)
    raise MoveError, "That move leaves your King in check" if king.in_check?(temp_board)
  end
  
  def get_temp_king(temp_board)
    if current_player.colour == :white
      temp_board.white_pieces.find { |piece| piece.class == King }
    else
      temp_board.black_pieces.find { |piece| piece.class == King }
    end  
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
  
  def set_king_objects
    self.white_king = self.board.white_pieces.find { |piece| piece.class == King }
    self.black_king = self.board.black_pieces.find { |piece| piece.class == King }
  end
  
  def change_player
    self.current_player = self.current_player == player1 ? player2 : player1
  end
  
  def check_status
    current_player.checked(current_king_in_check?)
  end
  
  def checkmate
    if current_player.in_check && king_moves_in_check? && no_blocking_pieces?
      puts board
      yield(current_player.name, other_player.name)
      throw(:finished)
    end
    nil
  end
  
  def draw
    if king_moves_in_check? && no_pieces_to_move
      puts board
      yield(current_player.name)
      throw(:finished)
    end
  end

  private
  
    def no_pieces_to_move
      get_current_pieces.all? { |piece| piece_moves_in_check?(piece) }
    end
    
    def piece_moves_in_check?(piece)
      piece.moves.any? { |move| piece_can_move?(piece, move) }
    end
    
    def piece_can_move?(piece, move)
      piece_cords = board.get_coordinates(piece)
      temp_board = create_temp_board
      temp_board.move_piece(piece_cords, move)
      temp_board.populate_piece_arrays
      temp_board.update_moves
      king = get_temp_king(temp_board)
      king.in_check?(temp_board) ? false : true
    end
  
    def other_player
      current_player == player1 ? player2 : player1
    end

    def set_player_to_go_first
      @player1.colour == :white ? @player1 : @player2
    end
    
    def piece_hash
      Pieces.to_hash.inject({}) do |hash, (piece_name, colour_hash) |
        hash.merge(PieceCreator.new(piece_name, colour_hash).create)
      end
    end
    
    def king_occupied?(node)
        return self.board.square(*node).class == King ? true : false
    end
    
    def create_temp_board
      Marshal.load(Marshal.dump(board))
    end
    
    def confirm_piece_moved
      board.square(*current_move[:end]).piece_moved
    end
    
    def current_king_in_check?
      get_king.in_check?(board)
    end
    
    def get_king
      current_player.colour == :white ? white_king : black_king
    end
    
    def king_moves_in_check?
      get_king.moves.all? { |cords| king_move_in_check?(cords) }
    end
    
    def king_move_in_check?(cords)
      king_cords = board.get_coordinates(get_king)
      temp_board = create_temp_board
      temp_board.move_piece(king_cords, cords)
      temp_board.populate_piece_arrays
      temp_board.update_moves
      king = get_temp_king(temp_board)
      king.in_check?(temp_board) ? true : false
    end
    
    def opposition_moves
      get_opposite_pieces.each_with_object([]) do |piece, moves_array|
        moves_array << piece.moves
      end
    end
    
    def get_opposite_pieces
      current_player.colour == :white ? board.black_pieces : board.white_pieces
    end
    
    def no_blocking_pieces?
      pieces = find_blocking_pieces
      return true if pieces.empty?
      return pieces.any? { |piece| piece_can_block?(piece) } ? false : true
    end
    
    def piece_can_block?(piece)
      piece_cords = board.get_coordinates(piece)
      move_cords = piece.moves.find { |move| danger_squares.include?(move) }
      temp_board = create_temp_board
      temp_board.move_piece(piece_cords, move_cords)
      temp_board.populate_piece_arrays
      temp_board.update_moves
      king = get_temp_king(temp_board)
      king.in_check?(temp_board) ? false : true
    end
    
    def danger_squares
      find_check_piece.get_danger_squares(board, board.get_coordinates(get_king))
    end
    
    def find_check_piece
      get_opposite_pieces.find {|piece| piece.moves.include?(board.get_coordinates(get_king)) }
    end
    
    def get_current_pieces
      current_player.colour == :white ? board.white_pieces : board.black_pieces
    end 
    
    def find_blocking_pieces
      get_current_pieces.find_all {|piece| blocking_piece?(piece) }
    end
    
    def blocking_piece?(piece)
      piece.moves.any? { |move| danger_squares.include?(move) }
    end
end