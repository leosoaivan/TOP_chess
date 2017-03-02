require_relative 'boardprint.rb'

class Board
  include BoardPrint
  
  attr_accessor :data, :black_pieces, :white_pieces
  
  def initialize
    @data = Array.new(8) { Array.new(8) }
    @black_pieces = []
    @white_pieces = []
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
    data.fetch(row).fetch(column)
  end
  
  def move_piece(start_position, end_position)
    place_piece(get_piece(start_position), end_position)
    set_start_square_to_nil(start_position)
  end
  
  def add_piece(piece, position)
    data[position[0]][position[1]] = piece
  end
  
  def get_coordinates(piece)
    data.each_with_index do |row, row_index|
      row.each_with_index do |square, square_index|
        return [row_index, square_index] if square == piece
      end
    end
  end
  
  def populate_piece_arrays
    clear_piece_arrays
    data.each do |row|
      row.each do |square|
        next if square.nil?
        square.colour == :white ? @white_pieces << square : @black_pieces << square
      end
    end
  end
    
  def update_moves
    game_pieces.each do |piece|
      piece.generate_moves(self)
    end
  end

  private
  
    def get_piece(position)
      self.square(*position)
    end
  
    def place_piece(piece, position)
      self.data[position[0]][position[1]] = piece
    end
    
    def set_start_square_to_nil(position)
      self.data[position[0]][position[1]] = nil
    end
    
    def game_pieces
      white_pieces + black_pieces
    end
    
    def clear_piece_arrays
      self.black_pieces = []
      self.white_pieces = []
    end
end