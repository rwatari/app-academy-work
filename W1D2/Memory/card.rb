class Card
  attr_reader :face_value, :face_up

  def initialize(face_value)
    @face_value = face_value
    @face_up = false
  end

  def display
    face_up ? to_s : "$$"
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(other)
    face_value == other.face_value
  end

  def to_s
    string = face_value.to_s
    if string.length == 1
      " #{string}"
    else
      string
    end
  end
end
