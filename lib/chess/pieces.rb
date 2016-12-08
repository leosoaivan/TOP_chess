class Pieces

  def self.to_hash
    new.to_hash
  end

  def to_hash
    {
      Pawn: pawns_pieces,
      Rook: rook_pieces,
      Knight: knight_pieces,
      Bishop: bishop_pieces,
      King: king_pieces,
      Queen: queen_pieces,
    }
  end

  private

  def pawns_pieces
    {
      white: [[6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7]],
      black: [[1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7]]
    }
  end

  def rook_pieces
    { white: [[7,0],[7,7]], black: [[0,0],[0,7]] }
  end

  def knight_pieces
    { white: [[7,1],[7,6]], black: [[0,1],[0,6]] }
  end

  def bishop_pieces
    { white: [[7,2],[7,5]], black: [[0,2],[0,5]] }
  end

  def king_pieces
    { white: [[7,3]], black: [[0,3]] }

  end

  def queen_pieces
    { white: [[7,4]], black: [[0,4]] }
  end
end