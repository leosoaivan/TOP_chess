require 'spec_helper'

describe Queen do
  let(:queen) { Queen.new(:white) }
  let(:board) { double 'Board' }
  let(:piece) { double 'Piece' }
  let(:piece2) { double 'Piece2' }
  
  describe '#valid_move?' do
    context 'when the end co-ordinate is not in the queen move array' do
      it 'returns false' do
        expect(queen.valid_move?([3,3], [2,6], board)).to be false
      end
    end
    
    context 'when the end co-ordinate path is blocked by another piece' do
      it 'returns false' do
        allow(queen).to receive(:convert_coordinartes).and_return([piece, nil, piece2])
        expect(queen.valid_move?([3,3], [4,2], board)).to be false
      end
    end
    
    context 'when the move is valid' do
      it 'returns true' do
        allow(queen).to receive(:convert_coordinartes).and_return([piece, nil, nil])
        expect(queen.valid_move?([3,3], [4,2], board)).to be true
      end
    end
  end
  
end