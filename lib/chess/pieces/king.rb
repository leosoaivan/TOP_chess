class King < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  def valid_move?(start, finish, board)
    get_directions(start).any? { |coordinates| coordinates.include?(finish) } \
                && path_not_blocked?(start, finish, board)
  end
  
  def in_check?(coordinate, board)
    row_and_column_check?(coordinate, board) || diagonal_check?(coordinate, board) \
                            || pawn_check?(coordinate, board) || next_to_king_check?(coordinate, board) \
                                      || knight_check?(coordinate, board)
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2654" : "\u265A"
    end
    
    def get_directions(start)
      [left_to_right_diagonal_coordinates(start), right_to_left_diagonal_coordinates(start),
              row_coordinates(start), column_coordinates(start)]
    end
    
    def path_not_blocked?(start, finish, board)
      get_array(start, finish)[1] == finish
    end
    
    def get_array(start, finish)
      find_array(start, finish) do |array|
        if array.index(start) < array.index(finish)
          return array[array.index(start)..array.index(finish)]
        else
          return array.reverse![array.index(start)..array.index(finish)]
        end
      end
    end
    
    def find_array(start, finish)
      get_directions(start).each do |array|
        yield array if array.include?(finish)
      end
    end
    
    def row_and_column_check?(coordinate, board)
      add_reversed_array(
        compact_array_convert_to_pieces(
          board, row_coordinates(coordinate), column_coordinates(coordinate)
          )
        ).any? {|array| king_check?(array, [Rook, Queen]) }
    end
    
    def diagonal_check?(coordinate, board)
      add_reversed_array(
        compact_array_convert_to_pieces(
          board, left_to_right_diagonal_coordinates(coordinate), right_to_left_diagonal_coordinates(coordinate)
          )
        ).any? {|array| king_check?(array, [Bishop, Queen]) }
    end
    
    def compact_array_convert_to_pieces(board, first_array, second_array)
      [first_array, second_array].each do |array|
        array.map {|cord| board.square(*cord) }.compact
      end
    end
    
    def add_reversed_array(array)
      array.each_with_object([]) do |sub_array, final_array|
        final_array << sub_array
        final_array << sub_array.reverse
      end
    end
    
    def king_check?(king_array, piece_array)
      index = king_array.index(self)
      return false if index == 0
      piece_array.any? {|piece| piece == king_array[index-1].class} && king_array[index-1].colour != self.colour
    end
    
    def knight_check?(coordinate, board)
      knight = [
        [-2, 1], [-2, -1], [-1, 2], [-1, -2],
        [1, -2], [1, 2], [2, 1], [2, -1]
      ]
      knight_array = knight.map {|square| square.zip(coordinate).map! {|x, y| x + y}}.drop_while {
          |x, y| x < 0 || x > 7 || y < 0 || y > 7
        }
      knight_array.map! {|cord| board.square(*cord)}
      knight_array.any? {|piece| piece.class == Knight && piece.colour != self.colour }
    end
    
    def next_to_king_check?(coordinate, board)
      king_moves = [
          [0,1], [1,0], [0,-1], [-1,0],
          [1,1], [1,-1], [-1,1], [-1,-1]
        ]
        king_array = king_moves.map {|square| square.zip(coordinate).map! {|x, y| x + y}}.drop_while {
          |x, y| x < 0 || x > 7 || y < 0 || y > 7
        }
        king_array.map! {|cord| board.square(*cord)}
        king_array.any? {|piece| piece.class == King}
    end
    
    def pawn_check?(coordinate, board)
      pawn_moves = self.colour == :white ? [[-1,-1],[-1,1]] : [[1,-1],[1,1]]
      pawn_array = pawn_moves.map {|square| square.zip(coordinate).map! {|x, y| x + y}}.drop_while {
          |x, y| x < 0 || x > 7 || y < 0 || y > 7
        }
      pawn_array.map! {|cord| board.square(*cord)}
      pawn_array.any? {|piece| piece.class == Pawn && piece.colour != self.colour }
    end
end