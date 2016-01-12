class Card

  attr_reader :face_value, :revealed

  def initialize(face_value, revealed = false)
    @face_value = face_value
    @revealed = revealed
  end


  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def to_s
    revealed ? @face_value : "-"
  end

  def ==(another_card)
    another_card.face_value == self.face_value
  end

end
