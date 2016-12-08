require 'spec_helper'

describe Game do
  subject(:game) { Game.new(board, player1, player2) }
  let(:board) { double 'Board' }
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
        expect(game.valid_input?(["a1", "b2"])).to be true
      end
    end
    
    context 'with an array element of length less than two' do
      it 'returns false' do
        expect(game.valid_input?(["a1", "b"])).to be false
      end
    end
    
    context 'with an array element of length more than two' do
      it 'returns false' do
        expect(game.valid_input?(["a12", "b2"])).to be false
      end
    end
    
    context 'with an array element of incorrect characters' do
      it 'returns false' do
        expect(game.valid_input?(["a1", "b9"])).to be false
      end
    end
    
    context 'with an array element of non-characters' do
      it 'returns false' do
        expect(game.valid_input?(["a1", "b?"])).to be false
      end
    end
  end
  
  describe '#split_player_input' do
    
    let(:input) { "A1 to B2" }
    
    it 'converts an input into an array' do
      expect(game.split_player_input(input)).to be_kind_of Array
    end
    
    it 'returns an array of two elements' do
      expect(game.split_player_input(input)).to eql ["a1", "b2"]
    end
    
    it 'each element of the returned array is two characters long' do
      expect(game.split_player_input(input)[0].length).to eql 2
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
  
  describe '#setup_board' do
    it 'should send the pieces to the board' do
      expect(board).to receive(:add_piece).exactly(32).times
      game.setup_board
    end
  end
end