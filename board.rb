require_relative 'piece'

class Board

  def initialize()
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
    raise "You're going out of the board" unless valid_move?
  end

end
