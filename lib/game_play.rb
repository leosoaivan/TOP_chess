require 'board'
require 'game'

def welcome_screen
  puts "Welcome to Chess"
  puts "Enter 0 for a new game or 1 to load a game"
end

def get_response
  response = gets.chomp
  until response == 0 or response == 1
    get_response
  end
  response
end

def create_save_file
end

def setup_new_game
  create_save_file
end

def game_loop
  welcome_screen
  response = get_response
  if response == 0
    setup_new_game
  else
    load_game
  end
end