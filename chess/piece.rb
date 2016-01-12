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
  def valid_move?(pos)
    #within bounds && does not cross an ally/ piece of same color
    pos.all?{ |i| i.between?(0, 7) } && @board[pos].color != @color
  end

  def cross_ennemies?(pos)
    if @color == :black
      @board[pos].color == :white
    elsif @color == :white
      @board[pos].color == :black
    end
  end

  def update_position(end_pos)
    @pos = end_pos
  end

  def inspect
    [@name, @color, @pos].inspect
  end


end

class Queen < Piece
  include SlidingPieces

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :queen
    @movements = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
      ]
  end

  def to_s
    case @color
    when :white then "  \u2655  "
    when :black then "  \u265B  "
    end
  end

end

class Bishop < Piece
  include SlidingPieces

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :bishop
    @movements = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]]
  end

  def to_s
    case @color
    when :white then "  \u2657  "
    when :black then "  \u265D  "
    end
  end
end

class Rook < Piece
  include SlidingPieces

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :rook
    @movements = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
    ]
  end

  def to_s
    case @color
    when :white then "  \u2656  "
    when :black then "  \u265C  "
    end
  end

end

class Knight < Piece
  include SteppingPieces

  # MOVEMENTS = [
  #   [1, 2],
  #   [2, 1],
  #   [-1, -2],
  #   [-1, 2],
  #   [1, -2],
  #   [2, -1],
  #   [-2, -1],
  #   [-2, 1]
  # ]

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :knight

    @movements = [
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

  def to_s
    case @color
    when :white then "  \u2658  "
    when :black then "  \u265E  "
    end
  end

end

class King < Piece


  include SteppingPieces

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :king

    @movements = [
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
