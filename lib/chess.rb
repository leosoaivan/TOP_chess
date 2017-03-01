require_relative 'chess/game_play'
require_relative 'chess/board'
require_relative 'chess/game'
require_relative 'chess/player'
require_relative 'chess/coordinate_converter'
require_relative 'chess/piece_creator'
require_relative 'chess/pieces'
require_relative 'chess/pieces/piece'
require_relative 'chess/pieces/move_array'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/knight'
require_relative 'chess/pieces/pawn'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'

extend Chess

puts chess_welcome
player1_name = get_player_name(1)
player2_name = get_player_name(2)

player1 = Player.new(player1_name, game_colours.sample)
player2 = Player.new(player2_name, get_other_colour(player1))
board = Board.new

puts "#{player1.name}, you are #{player1.colour}"
puts "#{player2.name}, you are #{player2.colour}"

game = Game.new(board, player1, player2)
game.setup_board
game.board.populate_piece_arrays
game.set_king_objects
game.board.update_moves
play(game)
puts "Thanks for playing"