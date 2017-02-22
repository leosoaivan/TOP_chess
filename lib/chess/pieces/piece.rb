require_relative 'move_array'

class Piece
  include MoveArray
  attr_accessor :moves
  attr_reader :colour, :symbol, :move_set, :moved
  
  def initialize(colour)
    @colour = colour
    @moved = false
  end
  
  def to_s
    self.symbol.encode('utf-8')
  end
  
  def generate_moves
    clear_moves
    create_moves
  end
  
  def valid_move?(coordinate)
    self.moves.include?(coordinate)
  end
  
  def moved
    @moved ||= true
  end
  
  private
  
    def create_moves(start, board)
      self.move_set.each do |cord|
        next_node = start
        add_coordiantes(next_node, cord, start, board)
      end
    end
    
    def update_node(next_node, cord)
      next_node.zip(cord).map {|x,y| x - y }
    end
    
    def different_colour_piece?(node, board)
      board.square(*node).colour != self.colour
    end
    
    def add_coordinates(node, cord, start, board)
      while valid_node?(node, board) do
        self.moves << node unless node == start
        return if different_colour_piece?(node, board)
        node = update_node(node, cord)
      end
    end
    
    def clear_moves
      self.moves = nil
    end
    
    def invalid_node?(node)
      node.any? { |num| num < 0 || num > 7 }
    end
    
    def valid_node?(node, board)
      return false if invalid_node?(node) || same_colour?(node, board)
      true
    end
    
    def same_colour(node, board)
      unless board.square(*node).nil?
        return different_colour_piece?(node, board) ? false : true
      end
    end
end