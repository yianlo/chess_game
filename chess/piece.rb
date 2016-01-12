# require_relative 'move_modules'


class Piece

  attr_reader :name, :color, :board

  def initialize(color = nil, board, initial_pos)
    @name = nil
    @color = color
    @board = board
    @pos = initial_pos
  end

  def to_s
    "   *   "
  end

  def avail_moves_array(pos)
    pot_moves = potential_moves(pos)
    pot_moves.select{ |move| within_bounds?(move) && uncross_piece?(move) }
  end

  def within_bounds?(pos) #TODO rethink name
    pos.all?{ |i| i.between?(0, 7) }
  end

  def uncross_piece?(pos)
    return false if @board[pos].color == @color
  end

  def update_position(end_pos)
    @pos = end_pos
  end



end


class SlidingPieces < Piece
  def initialize(color = nil, board, initial_pos)
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

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :queen
  end

  def to_s
    case @color
    when :white then "   \u2655   "
    when :black then "   \u265B   "
    end
  end

end

class Bishop < SlidingPieces
  include DiagonalMove

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :bishop
  end

  def to_s
    case @color
    when :white then "   \u2657   "
    when :black then "   \u265D   "
    end
  end
end

class Rook < SlidingPieces
  include PerpendicularMove

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :rook
  end

  def to_s
    case @color
    when :white then "   \u2656   "
    when :black then "   \u265C   "
    end
  end

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

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :knight
  end

  def to_s
    case @color
    when :white then "   \u2658   "
    when :black then "   \u265E   "
    end
  end
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

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :king
  end

  def to_s
    case @color
    when :white then "   \u2654   "
    when :black then "   \u265A   "
    end
  end
end

class Pawn < Piece
  # different cases
  ## first move of each pawn can be row +2
  ## when eating another piece pawn can move row +1 && col +1
  ## regular move

  def initialize(color = nil, board, initial_pos)
    super(color, board, initial_pos)
    @name = :pawn
  end

  def to_s
    case @color
    when :white then "   \u2659   "
    when :black then "   \u265F   "
    end
  end
end
