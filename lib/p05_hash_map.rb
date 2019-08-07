require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    return overwrite(key, val) if include?(key)

    @count += 1 if bucket(key).empty?
    bucket(key).append(key, val)
    resize! if @count == num_buckets - 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def find(key)
    bucket(key).find(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each { |node| yield [node.key, node.val] }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    hm = HashMap.new(num_buckets + num_buckets)
    each do |bucket|
      hm.set(bucket[0], bucket[1])
    end
    @store = hm.store
    @count = hm.count
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end

  def overwrite(key, val)
    bucket(key).update(key, val)
  end

end
