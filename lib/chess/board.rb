class Board
  attr_accessor :data
  
  def initialize
    @data = Array.new(8) { Array.new(8) }
  end
  
  def length
    data.length
  end
  
  def row(row_number)
    data[row_number]
  end
  
  def column(column_number)
    data.transpose[column_number]
  end
  
  def square(row, column)
    data[row][column]
  end
  
  def move_piece(start_position, end_position)
    place_piece(get_piece(start_position), end_position)
    set_start_square_to_nil(start_position)
  end
  
  def add_piece(piece, position)
    data[position[0]][position[1]] = piece
  end
  
  def to_s
    puts "    a   b   c   d   e   f   g   h "
    puts "  +---+---+---+---+---+---+---+---+"
    8.times do |x|
      print "#{ (x - 8).abs } |"
      @data[x].each do |elem|
        if elem
          print " #{elem}|"
        else
          print "   |"
        end
      end
      puts " #{ (x - 8).abs } \n"
      puts "  +---+---+---+---+---+---+---+---+"
    end
    puts "    a   b   c   d   e   f   g   h \n\n"
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