require_relative 'piece'

class Pawn < Piece
  
  def initialize(colour)
    super(colour)
    @symbol = set_symbol
    @move_set = pawn_colour_moves
  end
  
  private
  
    def set_symbol
      self.colour == :white ? "\u2659" : "\u265F"
    end
    
    def pawn_colour_moves
      self.colour == :white ? [[1,0],[1,1],[1,-1]] : [[-1,0],[-1,1],[-1,-1]]
    end
    
    def add_coordinates(node, cord, start, board)
      pawn_straight_moves(node, cord, board) if same_column(update_node(node, cord), start)
      pawn_diagonal_moves(node, cord, board) unless same_column(update_node(node, cord), start)
    end
    
    def pawn_straight_moves(node, cord, board)
      2.times do
        node = update_node(node, cord)
        moves << node if pawn_straight_move_valid?(node, board)
        return if self.moved
      end
    end
    
    def pawn_diagonal_moves(node, cord, board)
      moves << update_node(node, cord) if pawn_diagonal_move_valid?(update_node(node, cord), board)
    end
    
    def same_column(node, start)
      node[1] == start[1]
    end
    
    def pawn_straight_move_valid?(node, board)
      return false if invalid_node?(node)
      board.square(*node).nil? ? true : false
    end
    
    def pawn_diagonal_move_valid?(node, board)
      return false if invalid_node?(node) || board.square(*node).nil?
      board.square(*node).colour == self.colour ? false : true
    end
end