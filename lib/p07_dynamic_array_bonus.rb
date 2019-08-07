class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error with #{i}" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray

  include Enumerable

  attr_reader :store
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i >= 0 ? @store[i] : @store[negative_index(i)]
  end

  def []=(i, val)
    i >= 0 ? @store[i] = val : @store[negative_index(i)] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each { |e| return true if e == val }
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[count] = val
    @count += 1
    val
  end

  def unshift(val)
    @store = map.with_index do |_, i|
      self[i - 1] unless i.zero?
    end
    self[0] = val
  end

  def pop
    last_item = @store[count - 1] if valid_index?(count - 1)
    return nil unless last_item

    @store[count - 1] = nil
    @count -= 1
    last_item
  end

  def shift
    first_e = first
    @store = map.with_index do |_, i|
      i == @count - 1 ? nil : (self[i + 1] if valid_index?(i + 1))
    end
    @count -= 1
    first_e
  end

  def first
    self[0]
  end

  def last
    self[count - 1]
  end

  def each
    i = 0
    while i < capacity
      yield self[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    each_with_index do |e, i|
      return false unless e == other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def negative_index(i)
    capacity + i
  end

  def valid_index?(i)
    i.between?(0, capacity - 1)
  end

  def resize!
    newarr = DynamicArray.new(capacity + capacity)
    each { |e| newarr.push(e) }
    @store = newarr.store
  end
end

arr = DynamicArray.new
arr.push(1)
arr.push(2)
p arr.pop
