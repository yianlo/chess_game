module SlidingPieces
  # def initialize(color = nil, board, initial_pos)
  #   super(name, color)
  # end
  def potential_moves
    potential_moves = []

    self.class::MOVEMENTS.each do |m|
      new_pos = @pos
      ennemies_crossed_counter = 0
      while valid_move?(new_pos) && ennemies_crossed_counter <= 1

        ennemies_crossed_counter += 1 if cross_ennemies?(new_pos)
        potential_moves << new_pos if ennemies_crossed_counter < 2

        new_pos = [new_pos[0] + m[0], new_pos[1] + m[1]]
      end
    end

    potential_moves.reject{|m| m == @pos}
  end
end

module SteppingPieces
  def potential_moves
    potential_moves = []

    self.class::MOVEMENTS.each do |m|
      new_pos = [@pos[0] + m[0], @pos[1] + m[1]]
      potential_moves << new_pos if valid_move?(new_pos)
    end

    potential_moves
  end
end
