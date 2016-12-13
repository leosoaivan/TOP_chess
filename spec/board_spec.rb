require 'spec_helper'

describe Board do
  subject(:board) { Board.new }
  let(:piece) { double 'Piece' }
  
  it { expect(board).to be_instance_of Board }
  
  describe '#row' do
    it 'returns the requested row' do
      expect(board.row(2)).to eql board.data[2]
    end
  end
  
  describe '#column' do
    it 'returns the requested column' do
      expect(board.column(1)).to eql board.data.transpose[1]
    end
  end
  
  describe '#square' do
    it 'returns the requested square at the given co-ordinate' do
      expect(board.square(1, 3)).to eql board.data[1][3]
    end
  end
  
  describe '#move_piece' do
    it 'moves the piece from the start position to the end position' do
      board.data[1][2] = piece
      board.move_piece([1,2],[1,3])
      expect(board.data[1][3]).to eql piece
      expect(board.data[1][2]).to be_nil
    end
  end
  
  describe '#add_piece' do
    it 'adds the piece to the co_ordinates provided' do
      board.add_piece(piece, [6,0])
      expect(board.data[6][0]).to eql piece
    end
  end
end