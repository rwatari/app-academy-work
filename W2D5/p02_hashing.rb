class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, idx|
      sum ^= (el * idx).hash
    end
    sum
  end
end

class String
  def hash
    self.chars.map { |el| el.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |key, value|
      sum ^= key.hash ^ value.hash
    end
    sum
  end
end
