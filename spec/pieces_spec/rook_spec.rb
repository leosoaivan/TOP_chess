require 'spec_helper'

describe Rook do
  let(:rook) { Rook.new(:white) }
  let(:board) { double 'Board' }
  let(:piece) { double 'Piece' }
  let(:piece2) { double 'Piece2' }
  
  describe '#valid_move?' do
    context 'when the end co-ordinate is not horizontal to the Rook' do
      it 'returns false' do
        expect(rook.valid_move?([3,3], [4,4], board)).to be false
      end
    end
    
    context 'when the end co-ordinate path is blocked by another piece' do
      it 'returns false' do
        allow(rook).to receive(:convert_coordinates).and_return([piece, nil, piece2])
        expect(rook.valid_move?([3,3], [3,6], board)).to be false
      end
    end
    
    context 'when the move is valid' do
      it 'returns true' do
        allow(rook).to receive(:convert_coordinates).and_return([piece, nil, nil])
        expect(rook.valid_move?([3,3], [3,6], board)).to be true
      end
    end
  end
  
end