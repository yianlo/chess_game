require_relative 'card.rb'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(4) { Array.new(4) }
    populate
  end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
  end


  def populate
    num_pairs = (size ** 2) / 2
    cards = Card.shiffled_pairs(num_pairs)
    rows.each_index do |i|
      row.each_index do |j|
        self[[i, j]] = card.pop
      end
    end
  end

  def render

  end

  def reveal(guessed_pos)
    if revealed(guessed_pos)
      puts "You can't reveal a card that has already been revealed."
    else
      self[guessed_pos].reveal
    end
    self[guessed_pos].value
  end

  def won?
    rows.all?{ |row| row.all? { |card| card.revealed? }}
  end


end
