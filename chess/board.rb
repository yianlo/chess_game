require_relative 'piece'

class Board
  WHITE_POSITIONS = {
    pawns: [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]],
    rook: [[7, 0], [7, 7]],
    knight: [[7, 1], [7, 6]],
    bishop: [[7, 2], [7, 5]],
    queen: [[7, 3]],
    king: [[7, 4]]
  }

  BLACK_POSITIONS = {
    pawns: [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]],
    rook: [[0, 0], [0, 7]],
    knight: [[0, 1], [0, 6]],
    bishop: [[0, 2], [0, 5]],
    queen: [[0, 3]],
    king: [[0, 4]]
  }

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    populate
  end

  def populate
    #populate with nil pieces first
    @grid.each_with_index do |row, i|
      row.each_index do |j|
        self[[i, j]] = Piece.new(nil, self, [i, j])
      end
    end
    populate_chess_pieces(BLACK_POSITIONS, :black)
    populate_chess_pieces(WHITE_POSITIONS, :white)

  end

  def populate_chess_pieces(hash, color)
    hash.each do |piece, pos_array|
      pos_array.each do |pos|
        self[pos] = case piece
        when :pawns then Pawn.new(color, self, pos)
        when :rook then Rook.new(color, self, pos)
        when :knight then Knight.new(color, self, pos)
        when :bishop then Bishop.new(color, self, pos)
        when :queen then Queen.new(color, self, pos)
        when :king then King.new(color, self, pos)
        end
      end
    end

  end

  def get_king_pos(color)
    king = grid.flatten.select { |el| el.is_a?(King) && el.color == color }
    king.first.pos
  end

  def get_enemies_valid_moves(color)
    enemies_valid_moves = []

    enemies = get_enemies(color)
    enemies.each do |enemy|
      enemies_valid_moves.concat(enemy.valid_moves_array)
    end

    enemies_valid_moves
  end

  def get_enemies(color)
    enemy_color = (color == :white) ? :black : :white

    grid.flatten.select{ |piece| piece.color == enemy_color }
  end

  def in_check?(color)
    king_pos = self.get_king_pos(color)
    enemies_moves = self.get_enemies_valid_moves(color)

    enemies_moves.each{ |move| return true if move == king_pos }
    false
  end

  def lose_by_checkmate?(color)
    enemy_color = (color == :white) ? :black : :white
    in_check?(color) && get_enemies_valid_moves(enemy_color).empty?
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

    # raise "No pieces here" if self[start].name == nil
    # raise "You can't move here" unless valid_move? #TODO write out valid_move? method
    # raise "You can't move here" if self[end_pos].name != nil && self[start].color == self[end_pos].color

    if self[start].valid_moves.include?(end_pos)
      self[start].update_position(end_pos)
      self[end_pos] = self[start]
      self[start] = Piece.new(nil, self, start)
    end

    self
  end

  def in_bounds?(new_pos)
    new_pos.all?{ |i| i.between?(0, 7) }
  end

  def dup
    dupped_board = Board.new

    dupped_board.grid.each_with_index do |row, i|
      row.each_index do |j|
        dupped_board[[i, j]] = self[[i, j]].dup
      end
    end

    dupped_board
  end



end
