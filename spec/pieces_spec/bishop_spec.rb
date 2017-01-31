require 'spec_helper'

describe Bishop do
  let(:bishop) { Bishop.new(:white) }
  let(:board) { double 'Board' }
  let(:piece) { double 'Piece' }
  let(:piece2) { double 'Piece2' }
  
  describe '#valid_move?' do
    context 'when the end co-ordinate is not diagonal to the Bishop' do
      it 'returns false' do
        expect(bishop.valid_move?([3,3], [3,4], board)).to be false
      end
    end
    
    context 'when the end co-ordinate path is blocked by another piece' do
      it 'returns false' do
        allow(bishop).to receive(:convert_coordinartes).and_return([piece, nil, piece2])
        expect(bishop.valid_move?([3,3], [4,2], board)).to be false
      end
    end
    
    context 'when the move is valid' do
      it 'returns true' do
        allow(bishop).to receive(:convert_coordinartes).and_return([piece, nil, nil])
        expect(bishop.valid_move?([3,3], [4,2], board)).to be true
      end
    end
  end
  
end