require 'spec_helper'

describe Game do
  subject(:game) { Game.new(player1, player2) }
  let(:player1) { double 'Player1', colour: :white }
  let(:player2) { double 'Player2', colour: :black }
  
  it { expect(subject).to be_instance_of Game }
  
  describe '#set_player_to_go_first' do
    it 'sets the player with the colour white as the current player' do
      expect(game.current_player).to eql player1
    end
  end
  
  describe '#valid_input?' do
    context 'with a valid input' do
      it 'returns true' do
        expect(game.valid_input?("A1B4")).to be true
      end
    end
    
    context 'with an input of less than four in length' do
      it 'returns false' do
        expect(game.valid_input?("A1B")).to be false
      end
    end
    
    context 'with an input of more than four in length' do
      it 'returns false' do
        expect(game.valid_input?("A1B3C5")).to be false
      end
    end
    
    context 'with an input of incorrect characters' do
      it 'returns false' do
        expect(game.valid_input?("A3B9")).to be false
      end
    end
    
    context 'with an input of non-characters' do
      it 'returns false' do
        expect(game.valid_input?("A3B?")).to be false
      end
    end
  end
  
  describe '#split_player_input' do
    
    it 'converts an input into an array' do
      expect(game.split_player_input("A1B2")).to be_kind_of Array
    end
    
    it 'returns an array of two elements' do
      expect(game.split_player_input("A1B2")).to eql ["A1", "B2"]
    end
    
    it 'each element of the returned array is two characters long' do
      expect(game.split_player_input("A1B2")[0].length).to eql 2
    end
  end
  
  describe '#parse_input' do
    context 'when there is spaces either side of the input' do
      it 'strips the white space' do
        expect(game.parse_input("  a1b2  ")).to eql "a1b2"
      end
    end
    
    context 'when there are spaces between the input' do
      it 'strips the white space' do
        expect(game.parse_input("a1 b2")).to eql "a1b2"
      end
    end
  end
  
  describe '#change_player' do
    context 'on the first turn' do
      it 'player1 should be the current player' do
        expect(game.current_player).to eql player1
      end
    end

    context 'on the second turn' do
      it 'player2 should be the current player' do
        game.change_player
        expect(game.current_player).to eql player2
      end
    end
  end
  
end