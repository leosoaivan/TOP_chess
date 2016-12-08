class PieceCreator
  attr_reader :piece_name, :colour_hash

  def initialize(piece_name, colour_hash)
    @piece_name = piece_name
    @colour_hash = colour_hash
  end

  def create
    black_pieces.merge(white_pieces)
  end

  private

  def black_pieces
    black_piece_positions.inject({}) do |hash, position|
      hash.merge( position => create_piece('black'))
    end
  end

  def white_pieces
    white_pieces_positions.inject({}) do |hash, position|
      hash.merge( position => create_piece('white'))
    end
  end

  def create_piece(colour)
    Kernel.const_get(piece_name).new(colour.to_sym)
  end

  def white_pieces_positions
    colour_hash[:white]
  end

  def black_piece_positions
    colour_hash[:black]
  end
end