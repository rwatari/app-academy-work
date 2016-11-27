require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i += @count if i < 0
    return nil unless i.between?(0, @count - 1)
    @store[i]
  end

  def []=(i, val)
    i += @count if i < 0
    raise "too small" if i < 0
    self.push(nil) until @count - 1 >= i
    @store[i] = val

    @count += 1 unless include?(val)
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any? { |el| el == val }
  end

  def push(val)
    resize! if @count == @store.length
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == @store.length
    # (@count-1).downto(0)
    @count.downto(1) do |i|
      @store[i] = @store[i - 1]
    end
    @count += 1
    @store[0] = val
  end

  def pop
    return nil if @count == 0
    @count -= 1
    temp = @store[@count]
    @store[@count]
    temp
  end

  def shift
    return nil if @count == 0
    temp = @store[0]
    @count -= 1
    @count.times do |i|
      @store[i] = @store[i + 1]
    end
    @store[@count] = nil
    temp
  end

  def first
    return nil if @count == 0
    @store[0]
  end

  def last
    return nil if @count == 0
    @store[@count - 1]
  end

  def each
    count.times do |i|
      yield(@store[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    count.times do |i|
      return false unless self[i] == other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    temp = StaticArray.new(2 * capacity)
    count.times do |i|
      temp[i] = self[i]
    end
    @store = temp
  end
end
