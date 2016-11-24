class InvalidRowError < StandardError
end

class InvalidColumnError < StandardError
end

class InvalidSquareError < StandardError
end

class Board
  attr_accessor :data
  
  def initialize
    @data = Array.new(8) { Array.new(8) }
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

end