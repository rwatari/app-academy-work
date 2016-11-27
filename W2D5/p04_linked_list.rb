class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end


class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:HEAD)
    @tail = Link.new(:TAIL)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end

  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find(key)
    node.nil? ? nil : node.val
  end

  def include?(key)
    find(key) ? true : false
  end

  def append(key, val)
    return if include?(key)
    link = Link.new(key, val)
    @tail.prev.next = link
    link.prev = @tail.prev
    @tail.prev = link
    link.next = @tail
  end

  def update(key, val)
    node = find(key)
    node.nil? ? nil : node.val = val
  end

  def remove(key)
    node = find(key)
    node.nil? ? nil : node.remove
  end

  def each
    return [] if first.nil?
    curr_node = first
    until curr_node.next.nil?
      yield(curr_node)
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def find(key)
    return nil if empty?

    curr_node = first
    until curr_node.next == nil
      return curr_node if curr_node.key == key
      curr_node = curr_node.next
    end

    nil
  end
end
