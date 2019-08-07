require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
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
    return update_node!(@map.find(key).val) if @map.include?(key)

    value = calc!(key)
    eject! if count > @max

    value
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    newnode = @store.append(key, @prc.call(key))
    @map.set(key, newnode)
    newnode.val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    puts node.to_s
    @store.append_node(node)
    node.val
  end

  def eject!
    node = @store.first
    @store.remove(node.key)
    @map.delete(node.key)
  end
end

prc = Proc.new { |x| x**2 }
lru = LRUCache.new(3, prc)
lru.get(1)
lru.get(2)
lru.get(3)
lru.get(2)
puts lru.to_s


