require_relative 'board.rb'

class Game
  attr_accessor :guessed_pos

  def initialize(board = Board.new)
    @board = board
    @previous_guess = nil
    @guessed_pos = nil
  end

  def play

    until win?
      board.render
      prompt_player

    end
  end

  def prompt_player
    puts "Please select the coordonates of the first card you want to reveal: "
    first_guess = gets.chomp
    # begin
    puts "Nice one ;) Now select the coordonates of the second card you want to reveal: "
    second_guess = gets.chomp
    if second_guess == first_guess
      puts "Don't select the same card bro!"
    end
    # retry
  end

end
