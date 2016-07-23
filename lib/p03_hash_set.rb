require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key.hash] << key.hash unless self.include?(key.hash)
    @count += 1
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    self[key.hash].delete(key.hash)
    @count -= 1
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
    new_size = num_buckets * 2
    temp = Array.new(new_size) { Array.new }
    @store.each do |el|
      el.each do |el2|
        temp[el2 % new_size] << el2
      end
    end
    num_buckets = new_size
    @store = temp
  end
end
