require_relative 'piece'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    populate
  end

  def populate
    @grid.each_with_index do |row, i|
      row.each_index do |j|
        self[[i, j]] = Piece.new
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, input)
    row, col = pos
    @grid[row][col] = input
  end



  def move(start, end_pos)
    raise "No pieces here" if self[start].name == null
    raise "You can't move here" unless valid_move? #TODO write out valid_move? method
    raise "You can't move here" if self[end_pos].value != null && self[start].color == self[end_pos].color
  end



  def in_bounds?(new_pos)
    new_pos.all?{ |i| i.between?(0, 7) }
  end



end
