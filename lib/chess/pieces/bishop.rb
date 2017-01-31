class Bishop < Piece
  attr_reader :symbol, :move_set
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
  end
  
  def valid_move?(start, finish, board)
    get_directions(start).any? { |coordinates| coordinates.include?(finish) } \
                && path_not_blocked?(start, finish, board)
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2657" : "\u265D"
    end
    
    def get_directions(start)
      [left_to_right_diagonal_coordinates(start), right_to_left_diagonal_coordinates(start)]
    end
    
    def path_not_blocked?(start, finish, board)
      convert_coordinates(get_array(start, finish), board).compact.length == 1
    end
    
    def convert_coordinates(array, board)
      array.map {|piece| board.square(*piece) }
    end
    
    def get_array(start, finish)
      find_array(start, finish) do |array|
        if array.index(start) < array.index(finish)
          return array[array.index(start)...array.index(finish)]
        else
          return array.reverse![array.index(start)...array.index(finish)]
        end
      end
    end
    
    def find_array(start, finish)
      get_directions(start).each do |array|
        yield array if array.include?(finish)
      end
    end
end