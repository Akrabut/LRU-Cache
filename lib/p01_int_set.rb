class MaxIntSet
  attr_reader :store
  
  def initialize(max)
    @max = max
    @store = Array.new(@max)
  end

  def insert(num)
    is_valid?(num)
    return if @store[num]

    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    return unless @store[num]

    @store[num] = false
  end

  def include?(num)
    @store[num] || false
  end

private

  def is_valid?(num)
    raise Exception.new 'Out of bounds' if num > @max || num.negative?
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

s = IntSet.new(20)
s.insert(49)

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      self[num] << num
    end
    resize! if @count == @store.length-1
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # double the size and rehash
    new_set = ResizingIntSet.new(@store.length * 2)
    @store.each do |bucket|
      bucket.each do |ele|
        new_set.insert(ele)
      end
    end
    @store = new_set.store
    @count = new_set.count
  end
end
