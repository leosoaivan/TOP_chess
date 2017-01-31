class Rook < Piece
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
      self.colour == :white ? "\u2656" : "\u265C"
    end
    
    def get_directions(start)
      [row_coordinates(start), column_coordinates(start)]
    end
    
    def path_not_blocked?(start, finish, board)
      convert_coordinartes(get_array(start, finish), board).compact.length == 1
    end
    
    def convert_coordinartes(array, board)
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