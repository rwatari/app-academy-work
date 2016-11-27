require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_link!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    eject! if count == @max
    @store.append(key, val)
    @map[key] = @store.last
    val
  end

  def update_link!(link)
    link.remove
    key, val = link.key, link.val
    @store.append(key, val)
    @map[key] = @store.last
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end
