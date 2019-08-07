class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { [] }
    @count = 0
  end

  def insert(key)
    return if include?(key)

    self[key] << key
    @count += 1
    resize! if @count == num_buckets - 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless include?(key)

    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(num_buckets + num_buckets)
    @store.each do |bucket|
      bucket.each { |e| new_set.insert(e) }
    end
    @store = new_set.store
    @count = new_set.count
  end
end
