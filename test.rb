require_relative 'lib/chess'

@board = Board.new
@rook = Rook.new(:white)
@rook2 = Rook.new(:black)
@bishop = Bishop.new(:black)
@pawn2 = Pawn.new(:black)
@Bking = King.new(:black)
@board.data[5][2] = @rook
@board.data[7][3] = @rook2
@board.data[3][2] = @bishop
@board.data[5][6] = @pawn2
@board.data[0][2] = @Bking
@current_move = {start: [5,2], end: [4,2]}
@colour = :white

class MoveValidator
  attr_accessor :piece, :board, :start, :finish
  
  def setup(piece, board, start, finish)
    @piece, @board, @start, @finish = piece, board, start, finish
  end
  
  def get_moves
    piece_moves.each do |coordinates|
      
    end
  end
  
  private
  
    def piece_moves
      piece.move_set
    end
end


puts @board
move = MoveValidator.new
puts move.valid_move?(@rook, @board, @current_move[:start],@current_move[:end])
puts move.king_in_sight?(@rook, @board, @current_move[:start],@current_move[:end])

#puts MOVES[@rook.class.to_s.to_sym].inspect







=begin
class MoveValidator
  attr_accessor :piece, :board, :start, :finish
  
  MOVES = {
    Bishop: [[-1, -1], [-1, 1], [1, 1], [1, -1]],
    King: [[-1, -1], [-1, 1], [1, 1], [1, -1], [-1, 0], [0, 1], [1, 0], [0, -1]],
    Knight: [[-2, 1], [-2, -1], [-1, 2], [-1, -2],[1, -2], [1, 2], [2, 1], [2, -1]],
    Queen: [[-1, -1], [-1, 1], [1, 1], [1, -1],[-1, 0], [0, 1], [1, 0], [0, -1]],
    Rook: [[-1, 0], [0, 1], [1, 0], [0, -1]],
    BlackPawn: [[-1,0]],
    WhitePawn: [[1,0]]
  }
  
  def valid_move?(piece, board, start, finish)
    setup(piece, board, start, finish)
    moves.include?(finish)
  end
  
  def king_in_sight?(piece, board, start, finish)
    setup(piece, board, start, finish)
    !sights.empty?
  end
  
  def sights
    sights = { 
      :king_location => [],
      :blockers => []
    }
    get_piece_coordinates.each do |cord|
      next_node = start
      loop do
        next_node = update_node(next_node, cord)
        begin
          board.square(*next_node)
        rescue IndexError
          break
        end
        break if next_node.any? {|num| num < 0}
        if board.square(*next_node).kind_of?(King) && board.square(*next_node).colour != piece.colour
          sights[:king_location] << next_node
        end
      end
    end
    puts sights.inspect
    sights
  end
  
  def travel_back(start, king_location)
    next_node.zip(cord).map {|x,y| x - y }
  end
  
  def moves
    moves = []
    get_piece_coordinates.each do |cord|
    next_node = start
      loop do
        next_node = update_node(next_node, cord)
        begin
          board.square(*next_node)
        rescue IndexError
          break
        end
        break if next_node.any? {|num| num < 0}
        if board.square(*next_node).nil?
          moves << next_node
          break if piece.class == King
          break if piece.class == Knight
          break if piece.class == Pawn
          next
        end
        if board.square(*next_node).colour != piece.colour
          moves << next_node unless piece.class == Pawn
          break
        end
        break if board.square(*next_node).colour == piece.colour
      end
    end
    if piece.class == Pawn
      moves << check_diagonal_pawn_moves
    end
    puts moves.inspect
    moves
  end
  
  def check_diagonal_pawn_moves
    return_arr = []
    diagonal_moves = piece.colour == :white ? [[1,1],[1,-1]] : [[-1,1],[-1,-1]]
    diagonal_moves.each do |cord|
      next_node = update_node(start, cord)
      next if board.square(*next_node).nil?
      return_arr << next_node unless board.square(*next_node).colour == piece.colour
    end
    return_arr.empty? ? nil : return_arr.flatten
  end
  
  private
  
    def update_node(next_node, cord)
      next_node.zip(cord).map {|x,y| x - y }
    end
  
    def setup(piece, board, start, finish)
      @piece, @board, @start, @finish = piece, board, start, finish
    end
  
end
=end
