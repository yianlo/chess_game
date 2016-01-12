require 'colorize'
require_relative 'board'
require 'byebug'
require_relative 'cursor'

class Display

  include Cursorable

  def initialize
    @board = Board.new
    @cursor_pos = [0,0]
    @selected = false
  end

  def render
    @board.grid.each_with_index do |row, i1|
      # debugger
      row_line = "#{i1} "
      row.each_with_index do |piece, i2|
        # row_line += " #{piece.to_s} "
        row_line += colorize(piece, i1, i2)
      end
      puts row_line
    end

  end

  def colorize(piece, i1, i2)
    if [i1, i2] == @cursor_pos
      piece.to_s.colorize(piece.color).on_red
    elsif (i1 + i2).even?
      piece.to_s.colorize(piece.color).on_white
    else
      piece.to_s.colorize(piece.color).on_light_black
    end
  end





end
