require 'spec_helper'

describe Board do
  subject(:board) { Board.new }
  
  it { expect(board).to be_instance_of Board }
  
  describe '#row' do
    context 'when the row number is valid' do
      it 'returns the requested row' do
        expect(board.row(2)).to eql board.data[2]
      end
    end
    
    context 'when the row number is invalid' do
      it 'raises an InvalidRowError' do
        expect { board.row(8) }.to raise_error InvalidRowError
      end
    end
  end
  
  describe '#column' do
    context 'when the column is valid' do
      it 'returns the requested column' do
        expect(board.column(1)).to eql board.data.transpose[1]
      end
    end
    
    context 'when the column is invalid' do
      it 'raises an InvalidColumnError' do
        expect { board.column(8) }.to raise_error InvalidColumnError
      end
    end
  end
  
  describe '#square' do
    context 'when the square is valid' do
      it 'returns the requested square at the given co-ordinate' do
        expect(board.square(1, 3)).to eql board.data[1][3]
      end
    end
    
    context 'when the square is invalid' do
      it 'raises an InvalidSquareError' do
        expect { board.square(1,8) }.to raise_error InvalidSquareError
      end
    end
  end
end