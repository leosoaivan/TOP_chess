require 'spec_helper'

describe Board do
  subject(:board) { Board.new }
  
  it { expect(board).to be_instance_of Board }
  
  context 'when a new gameboard is created' do
    it 'should have 8 columns' do
      expect(board.length).to eql 8
    end
    
    it 'should have 8 rows' do
      expect(board[0].length).to eql 8
      expect(board[7].length).to eql 8
    end
  end
  
  describe 'parse_input' do
    
  end
  
  describe '#move_piece' do
    context 'when a start and end position' do
      it 'should move the piece to the end position'
    end
  end
end