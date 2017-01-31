require 'spec_helper'

describe Knight do
  let(:knight) { Knight.new(:white) }
  let(:piece1) { Knight.new(:white) }
  let(:piece2) { Knight.new(:black) }
  let(:board) { double 'Board' }

  describe '#valid_move?' do
    context 'when the co-ordinate is not one the Knight can move to' do
      it 'returns false' do
        allow(board).to receive(:square).and_return(:white)
        expect(knight.valid_move?([3,3], [3,4], board)).to be false
      end
    end
    
    context 'when the co-ordinate contains a piece of the same colour' do
      it 'returns false' do
        allow(board).to receive(:square).and_return(piece1)
        expect(knight.valid_move?([3,3], [5,2], board)).to be false
      end
    end
    
    context 'when the co-ordinate is valid' do
      it 'returns true' do
        allow(board).to receive(:square).and_return(piece2)
        expect(knight.valid_move?([3,3], [5,2], board)).to be true
      end
    end
  end
  
end