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
    raise "Overflow error #{i}" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @head = nil
    @tail = nil
  end

  def empty?
    @head.nil? && @tail.nil?
  end

  def count
    return 0 if empty?
    (@tail - @head) % capacity + 1
  end

  def [](i)
    i += count if i < 0
    return nil unless i.between?(0, count - 1)
    @store[ring_index(i)]
  end

  def []=(i, val)
    i += count if i < 0
    raise "too small" if i < 0
    self.push(nil) until count - 1 >= i
    @store[ring_index(i)] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any? { |el| el == val }
  end

  def push(val)
    resize! if count == @store.length
    empty? ? @head = @tail = 0 : @tail = (@tail + 1) % capacity
    @store[@tail] = val
  end

  def unshift(val)
    resize! if count == @store.length
    empty? ? @head = @tail = 0 : @head = (@head - 1) % capacity
    @store[@head] = val
  end

  def pop
    return nil if empty?
    temp = last
    temp_count = count
    @tail = (@tail - 1) % capacity
    @head = @tail = nil if temp_count == 1
    temp
  end

  def shift
    return nil if empty?
    temp = first
    temp_count = count
    @head = (@head + 1) % capacity
    @head = @tail = nil if temp_count == 1
    temp
  end

  def first
    @store[@head]
  end

  def last
    @store[@tail]
  end

  def each
    count.times do |i|
      yield(self[i])
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
    @head = 0
    @tail = count - 1 
    @store = temp
  end

  def ring_index(i)
    (i + @head) % capacity
  end
end
