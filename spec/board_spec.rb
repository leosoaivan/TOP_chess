require 'spec_helper'

describe Board do
  subject(:board) { Board.new }
  
  it { expect(board).to be_instance_of Board }
  
  context "when a new gameboard is created" do
    it "should have 8 rows" do
      expect(board.gameboard.length).to eql 8
    end
    
    it "should have 8 columns" do
      expect(board.gameboard[0].length).to eql 8
      expect(board.gameboard[7].length).to eql 8
    end
  end
end