class Piece
  attr_reader :name, :color, :board

  def initialize(color = nil, board, initial_pos)
    @name = nil
    @color = color
    @board = board
    @pos = initial_pos
  end

  def to_s
    "     "
  end

  # def avail_moves_array(pos)
  #   pot_moves = potential_moves(pos)
  #   pot_moves.select{ |move| within_bounds?(move) && uncross_piece?(move) }
  # end

  def within_bounds?(pos) #TODO rethink name
    pos.all?{ |i| i.between?(0, 7) }
  end

  def uncross_piece?(pos)
    !(@board[pos].color == @color)
  end

  def update_position(end_pos)
    @pos = end_pos
  end

  def inspect
    [@name, @color, @pos].inspect
  end


end


class SlidingPieces < Piece
  MOVEMENTS = []
  # def initialize(color = nil, board, initial_pos)
  #   super(name, color)
  # end

  def potential_moves(pos)
    potential_moves = []

    MOVEMENTS.each do |m|
      new_pos = pos
      while within_bounds?(new_pos) && uncross_piece?(new_pos)
        potential_moves << new_pos

        new_pos = [new_pos[0] + m[0], new_pos[1] + m[1]]
      end
    end

    potential_moves.reject{|m| m == pos}
  end
end

class SteppingPieces < Piece
  MOVEMENTS = []

  def potential_moves(pos)
    potential_moves = []

    MOVEMENTS.each do |m|
      new_pos = [pos[0] + m[0], pos[1] + m[1]]
      potential_moves << new_pos if within_bounds?(new_pos) && uncross_piece?(new_pos)
    end

    potential_moves
  end
end


class Queen < SlidingPieces
  include DiagonalMove
  include PerpendicularMove

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :queen
  end

  def to_s
    case @color
    when :white then "  \u2655  "
    when :black then "  \u265B  "
    end
  end

end

class Bishop < SlidingPieces
  include DiagonalMove

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :bishop
  end

  def to_s
    case @color
    when :white then "  \u2657  "
    when :black then "  \u265D  "
    end
  end
end

class Rook < SlidingPieces
  include PerpendicularMove

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :rook
  end

  def to_s
    case @color
    when :white then "  \u2656  "
    when :black then "  \u265C  "
    end
  end

end

class Knight < SteppingPieces
  MOVEMENTS = [
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
    @board = board
    @pos = initial_pos
    @color = color
    @name = :knight
  end

  def to_s
    case @color
    when :white then "  \u2658  "
    when :black then "  \u265E  "
    end
  end

end

class King < SteppingPieces
  MOVEMENTS = [
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
    @board = board
    @pos = initial_pos
    @color = color
    @name = :king
  end

  def to_s
    case @color
    when :white then "  \u2654  "
    when :black then "  \u265A  "
    end
  end
end

class Pawn < Piece
  # different cases
  ## first move of each pawn can be row +2
  ## when eating another piece pawn can move row +1 && col +1
  ## regular move

  MOVEMENTS = [
    [1, 0],
    [2, 0], # only for first move
    [1, 1], # pawn eating move
    [1, -1], # pawn eating move
    [-1, 0],
    [-2, 0], # only for first move
    [-1, 1], # pawn eating move
    [-1,-1] # pawn eating move
  ]

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :pawn
  end

  def to_s
    case @color
    when :white then "  \u2659  "
    when :black then "  \u265F  "
    end
  end

  def potential_moves(pos)
    # TODO: finish pawn potential moves

  end




end
