require 'spec_helper'

describe Game do
  subject(:game) { Game.new(board, player1, player2) }
  let(:board) { double 'Board' }
  let(:player1) { double 'Player1', colour: :white }
  let(:player2) { double 'Player2', colour: :black }
  
  it { expect(subject).to be_instance_of Game }
  
  describe '#change_player' do
    context 'before the player is changed' do
      it 'The player who is white should go first' do
        expect(game.current_player).to eql player1
      end
    end
    
    context 'on the second turn' do
      it 'The player who is black should go second' do
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
  
  describe '#move' do
    context 'when the input is valid' do
      before(:each) do
        allow(game).to receive(:gets).and_return('a2 to a3')
      end
    
      it 'should not raise any errors' do
        expect { game.move }.to_not raise_error
      end
    end
      
  end

end