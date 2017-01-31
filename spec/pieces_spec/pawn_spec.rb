require 'spec_helper'

describe Pawn do
  let(:w_pawn) { Pawn.new(:white) }
  let(:b_pawn) { Pawn.new(:black) }
  let(:board) { double 'Board' }
  
  describe '#valid_move?' do
    context 'when the coordinate is not in the move path' do
      it 'returns false' do
        expect(w_pawn.valid_move?([6,3], [2,5], board)).to be false
      end
    end
    context 'when the end co-ordinate is in the same row as the Pawn' do
      context 'and when the Pawn has not moved previously' do
        context 'and when the Pawn wants to move two squares forward' do
          context 'and when the path is not blocked by another piece' do
            it 'returns true' do
              allow(w_pawn).to receive(:convert_coordinates).and_return([w_pawn, nil, nil])
              expect(w_pawn.valid_move?([6,3], [4,3], board)).to be true
            end
          end
          
          context 'when the path is blocked by another piece' do
            it 'returns false' do
              allow(w_pawn).to receive(:convert_coordinates).and_return([w_pawn, nil, w_pawn])
              expect(w_pawn.valid_move?([6,3], [4,3], board)).to be false
            end
          end
        end
      end
    end
  end
end