class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  attr_accessor :head, :tail

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail && last == @head
  end

  def get(key)
    (found = find(key)) ? found.val : nil
  end

  def find(key)
    each { |link| return link if link.key == key }
    nil
  end

  def include?(key)
    find(key) ? true : false
  end

  def append(key, val)
    newnode = Node.new(key, val)
    append_before_tail(newnode)
  end

  def append_node(node)
    append_before_tail(node)
  end

  def update(key, val)
    return unless (node = find(key))

    node.val = val
  end

  def remove(key)
    find(key).remove
  end

  def each
    curr = @head.next
    until curr == @tail
      yield curr
      curr = curr.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def append_before_tail(node)
    node.prev = tail.prev
    node.next = tail
    @tail.prev.next = node
    @tail.prev = node
    node
  end
end

l = LinkedList.new
l.append(:first, 1)
l.update(:first, 2)
#p l