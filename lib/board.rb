require_relative 'errors'
include Errors

class Board
  attr_accessor :data
  
  def initialize
    @data = Array.new(8) { Array.new(8) }
  end
  
  def to_s
    string = ""
    count = 8
    data.each do |row|
      string += count.to_s
      string += "|"
      string += row.map { |e| e || " " }.join("|")
      string += "|"
      string += "\n"
      count -= 1
    end
    string += "  A B C D E F G H"
    string
  end
  
  def length
    data.length
  end
  
  def row(row_number)
    raise InvalidRowError unless @data[row_number]
    data[row_number]
  end
  
  def column(column_number)
    raise InvalidColumnError unless data.transpose[column_number]
    data.transpose[column_number]
  end
  
  def square(row, column)
    raise InvalidSquareError unless data[row] && data[column]
    data[row][column]
  end
  
  def move_piece(start_position, end_position)
    place_piece(get_piece(start_position), end_position)
    set_start_square_to_nil(start_position)
  end
  
  private
  
    def get_piece(position)
      square(position[0], position[1])
    end
  
    def place_piece(piece, position)
      data[position[0]][position[1]] = piece
    end
    
    def set_start_square_to_nil(position)
      data[position[0]][position[1]] = nil
    end
end