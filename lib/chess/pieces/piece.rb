class Piece
  attr_accessor :moves
  attr_reader :colour, :symbol, :move_set, :moved
  
  def initialize(colour)
    @colour = colour
    @moved = false
    @moves = []
  end
  
  def to_s
    self.symbol.encode('utf-8')
  end
  
  def generate_moves(board)
    clear_moves
    create_moves(board.get_coordinates(self), board)
  end
  
  def valid_move?(coordinate)
    moves.include?(coordinate)
  end
  
  def piece_moved
    @moved ||= true
  end
  
  def get_danger_squares(board, king_cords)
    start = board.get_coordinates(self)
    move_set.each do |cord|
      node = start
      danger_cords = []
      until invalid_node?(node)
        danger_cords << node
        node = update_node(node, cord)
        return danger_cords if node == king_cords
      end
    end
  end
  
  private
  
    def create_moves(coordinates, board)
      move_set.each do |cord|
        next_node = coordinates
        add_coordinates(next_node, cord, coordinates, board)
      end
    end
    
    def update_node(next_node, cord)
      next_node.zip(cord).map {|x,y| x - y }
    end
    
    def different_colour_piece?(node, board)
      board.square(*node).colour != self.colour
    end
    
    def add_coordinates(node, cord, start, board)
      while valid_node?(node, board) || node == start do
        self.moves << node unless node == start
        unless board.square(*node).nil?
          return if different_colour_piece?(node, board)
        end
        node = update_node(node, cord)
      end
    end
    
    def clear_moves
      self.moves = []
    end
    
    def invalid_node?(node)
      node.any? { |num| num < 0 || num > 7 }
    end
    
    def valid_node?(node, board)
      return false if invalid_node?(node) || same_colour?(node, board)
      true
    end
    
    def same_colour?(node, board)
      unless board.square(*node).nil?
        return different_colour_piece?(node, board) ? false : true
      end
      false
    end
end