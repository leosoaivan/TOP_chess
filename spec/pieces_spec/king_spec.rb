require 'spec_helper'

describe King do
  let(:king) { King.new(:white) }
  let(:board) { double 'Board' }
  
  describe '#valid_move?' do
    context 'when the end co-ordinate is not in the king move array' do
      it 'returns false' do
        expect(king.valid_move?([3,3], [3,5], board)).to be false
      end
    end
    
    context 'when the move is valid' do
      it 'returns true' do
        expect(king.valid_move?([3,3], [4,4], board)).to be true
      end
    end
  end
end