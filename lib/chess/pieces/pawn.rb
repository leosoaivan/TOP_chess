class Pawn < Piece
  attr_reader :symbol, :move_set, :moved
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @moved = false
  end
  
  def moved
    @moved ||= true
  end
  
  def valid_move?(start, finish, board)
    [column_coordinates(start), left_to_right_diagonal_coordinates(start), right_to_left_diagonal_coordinates(start)].any? \
              { |coordinates| coordinates.include?(finish) } \
                && path_not_blocked?(start, finish, board)
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2659" : "\u265F"
    end
    
    def path_not_blocked?(start, finish, board)
      column_path_check(start, finish, board) || diagonal_path_check(start, finish, board)
    end
    
    def column_path_check(start, finish, board)
      convert_coordinates(get_row_array(start, finish), board).compact.length == 1
    end
    
    def get_row_array(start, finish)
      if moved
        get_row_subarray(start, finish)
      else
        get_row_subarray(start, finish)[0..1]
      end
    end
    
    # If white, reverse the array, then return an array up to two moves
    def get_row_subarray(start, finish)
      ary = column_coordinates(start)
      if self.colour == :white
        ary.reverse!
      end
      ary[ary.index(start)..ary.index(start) + 2]
    end
    
    def diagonal_path_check(start, finish, board)
      return false if convert_coordinates(get_diagonal_array(start, finish), board).compact.length == 1
      convert_coordinates(get_diagonal_array(start, finish), board).last.colour != self.colour
    end
    
    def get_diagonal_array(start, finish)
      find_diagonal_array(start, finish) do |array|
        if self.colour == :white
          return array.reserve![array.index(start)..array.index(start)+1]
        else
          return array[array.index(start)..array.index(start)+1]
        end
      end
    end
    
    def find_diagonal_array(start, finish)
      [left_to_right_diagonal_coordinates(start), right_to_left_diagonal_coordinates(start)].each do |array|
        yield array if array.include?(finish)
      end
    end
    
    def convert_coordinates(array, board)
      array.map {|piece| board.square(*piece) }
    end
end