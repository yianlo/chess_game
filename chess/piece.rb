class Piece

  attr_reader :name, :color

  def initialize(name = nil, color = :black)
    @name = name
    @color = color
  end

  def to_s
    "*"
  end

  def move(pos)
    pot_moves = potential_moves(pos)
    pot_moves.select{ |move| within_bounds?(move) }
  end

  def within_bounds?(pos) #TODO rethink name
    pos.all?{ |i| i.between?(0, 7) }
  end

end


class SlidingPieces < Piece
  def initialize
    super(name, color)
  end


end

class SteppingPieces < Piece
  def potential_moves(pos)
    potential_moves = []
    MOVES.each do |move|
      potential_moves << [pos[0] + move[0], pos[1] + move[1]]
    end
    potential_moves
  end
end


class Queen < SlidingPieces
  include DiagonalMove
  include PerpendicularMove
end

class Bishop < SlidingPieces
  include DiagonalMove
end

class Rook < SlidingPieces
  include PerpendicularMove
end

class Knight < SteppingPieces
  MOVES = [
    [1, 2],
    [2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [2, -1],
    [-2, -1],
    [-2, 1]
  ]
end

class King < SteppingPieces
  MOVES = [
    [0, 1],
    [0, -1],
    [1, 0],
    [1, -1],
    [1, 1],
    [-1, 0],
    [-1, -1],
    [-1, 1]
  ]
end

class Pawn < Piece
  # different cases
  ## first move of each pawn can be row +2
  ## when eating another piece pawn can move row +1 && col +1
  ## regular move

end
