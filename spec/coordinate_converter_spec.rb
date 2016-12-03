require 'spec_helper'

describe CoordinateConverter do
  
  describe '.convert_input' do
    it "returns a coordinate from a chess board coordinate" do
      input = [["a","1"],["b","2"]]
      expect(CoordinateConverter.convert_input(input)).to eql([[7,0],[6,1]])
    end
  end
end