module DiagonalMove
# for the bishop and the queen
  MOVEMENTS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]
end
  # def potential_moves(pos)
  #   potential_moves = []
  #   (1..7).each do |i|
  #     new_row = pos[0] + i
  #     new_col = pos[1] + i
  #
  #     potential_moves << [new_row, new_col]
  #   end
  #
  #   potential_moves
  # end

module PerpendicularMove
  # for the rook and the queen
  MOVEMENTS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]
end

  # def potential_moves(pos) #pos = [row, col]
  #   potential_moves = []
  #
  #   (1..7).each do |move|
  #     new_row = pos[0] + move
  #     potential_moves << [new_row, pos[1]]
  #
  #     new_row = pos[0] - move
  #     potential_moves << [new_row, pos[1]]
  #   end
  #
  #   (1..7).each do |move|
  #     new_col = pos[1] + move
  #     potential_moves << [pos[0], new_col]
  #
  #     new_col = pos[1] - move
  #     potential_moves << [pos[0], new_col]
  #   end
  #
  #   potential_moves
  # end
