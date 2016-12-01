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
  
  describe '#split_player_input' do
    
    it 'converts an input into an array' do
      expect(game.split_player_input("A1B2")).to be_kind_of Array
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