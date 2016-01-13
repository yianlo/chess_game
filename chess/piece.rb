require_relative 'move_modules'

class Piece
  attr_reader :name, :color, :board, :pos

  def initialize(color = nil, board, initial_pos)
    @name = nil
    @color = color
    @board = board
    @pos = initial_pos
  end

  def to_s
    "     "
  end

  def valid_moves_array
    potential_moves.reject do |move|
      put_me_in_check?(move)
    end
  end

  def put_me_in_check?(proposed_move)
    @board.dup.move(@pos, proposed_move).in_check?(@color)
  end

  def valid_move?(pos)
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

  def dup
    self.class.new(@color, @board, @pos)
  end




end

class Queen < Piece
  include SlidingPieces

  MOVEMENTS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1],
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
    ]

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

class Bishop < Piece
  include SlidingPieces

  MOVEMENTS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]]

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

class Rook < Piece
  include SlidingPieces

  MOVEMENTS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]

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

class Knight < Piece
  include SteppingPieces

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

class King < Piece


  include SteppingPieces

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
    [-1, 0],
    [-2, 0], # only for first move
    [2, 0], # only for first move
    [1, 1], # pawn eating move
    [1, -1], # pawn eating move
    [-1, 1], # pawn eating move
    [-1,-1] # pawn eating move
  ]

  def initialize(color = nil, board, initial_pos)
    @board = board
    @pos = initial_pos
    @color = color
    @name = :pawn

    @initial_pos = initial_pos
  end

  def to_s
    case @color
    when :white then "  \u2659  "
    when :black then "  \u265F  "
    end
  end

  def potential_moves
    potential_moves = []

    if @pos == @initial_pos
      MOVEMENTS.first(4).each do |m|
        new_pos = [@pos[0] + m[0], @pos[1] + m[1]]
        potential_moves << new_pos if valid_move?(new_pos)
      end
    else
      MOVEMENTS.first(2).each do |m|
        new_pos = [@pos[0] + m[0], @pos[1] + m[1]]
        potential_moves << new_pos if valid_move?(new_pos)
      end
    end

    # TODO add the pawn eating moves to the potential moves
    potential_moves
  end




end
