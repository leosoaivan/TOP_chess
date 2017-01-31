require 'spec_helper'

describe Game do
  subject(:game) { Game.new(board, player1, player2) }
  let(:board) { double 'Board' }
  let(:player1) { double 'Player1', colour: :white }
  let(:player2) { double 'Player2', colour: :black }
  let(:piece) { double 'Piece', colour: :white }
  
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
  
  describe '#valid_input?' do
    context 'with a valid input' do
      it 'returns true' do
        expect(game.valid_input?({start: "a1", end: "b2"})).to be true
      end
    end
    
    context 'with an array element of length less than two' do
      it 'returns false' do
        expect(game.valid_input?({start: "a1", end: "b"})).to be false
      end
    end
    
    context 'with an array element of length more than two' do
      it 'returns false' do
        expect(game.valid_input?({start: "a12", end: "b2"})).to be false
      end
    end
    
    context 'with an array element of incorrect characters' do
      it 'returns false' do
        expect(game.valid_input?({start: "a1", end: "b9"})).to be false
      end
    end
    
    context 'with an array element of non-characters' do
      it 'returns false' do
        expect(game.valid_input?({start: "a1", end: "b?"})).to be false
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
  
  describe '#convert_input' do
    it 'converts the input into an array of board co-ordinates' do
      game.current_move = {start: "a1", end: "b2"}
      game.convert_input
      expect(game.current_move[:start]).to eql [7,0]
      expect(game.current_move[:end]).to eql [6,1]
    end
  end
  
  describe '#empty_square?' do
    context 'When a board square is empty' do
      it 'returns true' do
        #game.current_move = {start: "a1", end: "b2"}
        allow(board).to receive(:square).and_return(nil)
        expect(game.empty_square?(game.current_move[:start])).to be true
      end
    end
    
    context 'When a board square is not empty' do
      it 'returns false' do
        #game.current_move = {start: "a1", end: "b2"}
        allow(board).to receive(:square).and_return(piece)
        expect(game.empty_square?(game.current_move[:start])).to be false
      end
    end
  end
  
  describe '#already_occupied?' do
    before(:each) do
      game.current_move = {start: "a1", end: "b2"}
    end
    
    context 'when the end coordinate is occupied by a piece of the same colour' do
      it 'returns true' do
        allow(board).to receive(:square).and_return(piece)
        allow(game).to receive(:current_player).and_return(player1)
        expect(game.already_occupied?(game.current_move[:end])).to be true
      end
    end
    
    context 'when the end coordinate is empty' do
      it 'returns false' do
        allow(board).to receive(:square).and_return(nil)
        expect(game.already_occupied?(game.current_move[:end])).to be false
      end
    end
    
    context 'when the end coordinate is occupied by a piece that is not the same colour' do
      it 'returns false' do
        allow(board).to receive(:square).and_return(nil)
        allow(game).to receive(:current_player).and_return(player2)
        expect(game.already_occupied?(game.current_move[:end])).to be false
      end
    end
  end
  
  describe '#within_moveset?' do
    context 'when the move is within the pieces moveset' do
      it 'returns true' do
        allow(game).to receive(:current_move).and_return({start: [3,4], end: [5,2]})
        allow(game).to receive(:get_piece).and_return(piece)
        allow(piece).to receive(:move_set).and_return([[-1, -1], [-1, 1], [1, 1], [1, -1]])
        expect(game.within_moveset?).to be true
      end
    end
  end
  
  describe '#row_coordinates' do
    it 'returns an array of row coordinates for the given start point' do
      allow(board).to receive(:length).and_return(8)
      return_array = [[3,0],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7]]
      expect(game.row_coordinates([3,5])).to eql(return_array)
    end
  end
  
  describe '#column_coordinates' do
    it 'returns an array of column coordinates for the given start point' do
      allow(board).to receive(:length).and_return(8)
      return_array = [[0,3],[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],[7,3]]
      expect(game.column_coordinates([3,5])).to eql(return_array)
    end
  end
  
  describe '#left_to_right_diagonal_coordinates' do
    it 'returns an array of left to right diagonal coordinates for the given start point' do
      allow(board).to receive(:length).and_return(8)
      return_array = [[0, 2], [1, 3], [2, 4], [3, 5], [4, 6], [5, 7]]
      expect(game.left_to_right_diagonal_coordinates([3,5])).to eql(return_array)
    end
  end
  
  describe '#right_to_left_diagonal_coordinates' do
    it 'returns an array of right to left diagonal coordinates for the given start point' do
      allow(board).to receive(:length).and_return(8)
      return_array = [[1, 7], [2, 6], [3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]
      expect(game.right_to_left_diagonal_coordinates([3,5])).to eql(return_array)
    end
  end
  
  describe '#knight_coordinartes' do
    it 'returns an array of coordiantes the Knight can move to for the given start point' do
      return_array = [[6, 4], [6, 0], [5, 1], [5, 3]]
      expect(game.knight_coordinartes([7,2])).to eql(return_array)
    end
  end

end