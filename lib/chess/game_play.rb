module Chess
  def chess_welcome
    <<-FOO
      ______  __    __   _______     _______.     _______.
     /      ||  |  |  | |   ____|   /       |    /       |
    |  ,----'|  |__|  | |  |__     |   (----`   |   (----`
    |  |     |   __   | |   __|     \\   \\        \\   \\    
    |  `----.|  |  |  | |  |____.----)   |   .----)   |   
     \\______||__|  |__| |_______|_______/    |_______/    
                                                          
    FOO
  end
  
  def get_player_name(number)
    print "Enter your name player#{number}: "
    name = gets.chomp
    name
  end
  
  def game_colours
    [:white, :black]
  end
  
  def get_other_colour(player)
    player.colour == :white ? :black : :white
  end
  
  def clear_screen
    print %x{clear}
  end
  
  def play(game)
    catch(:finished) do
      loop do
        puts game.board
        puts "#{game.current_player.name}, You are in check" if game.current_player.in_check
        puts "#{game.current_player.name}, it's your turn! Please make a move in the following format - a1 to b2"
        game.move { |error| puts error }
        game.board.populate_piece_arrays
        game.board.update_moves
        game.change_player
        game.check_status
        game.checkmate { |current_player, other_player| puts "Sorry, #{current_player}. It's checkmate. #{other_player} is the winner!" }
        game.draw { |current_player| puts "#{current_player} cannot move without being in check. The game is tied!" }
        clear_screen
      end
    end
  end
end