class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(el)
    @store << el
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end


class StackQueue
  def initialize
    @in = MyStack.new
    @out = MyStack.new
  end

  def enqueue(el)
    @out.push(@in.pop) until @in.empty?

    @in.push(el)

    @in.push(@out.pop) until @out.empty?
  end

  def dequeue
    @out.push(@in.pop)
    @out.pop
  end

  def peek
    @in.peek
  end

  def size
    @in.size
  end

  def empty?
    @in.empty?
  end
end

class MaxMinStack

end
