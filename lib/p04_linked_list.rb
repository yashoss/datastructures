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
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @tail.prev = @head
    @head.next = @tail
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
    @head.next.nil?
  end

  def get(key)
    node = @head.next
    until node == @sentinel_end
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    return true unless get(key).nil?
    false
  end

  def insert(key, val)
    remove(key)
    new_link = Link.new(key, val)
    temp = @tail.prev
    @tail.prev = new_link
    new_link.prev = temp
    new_link.next = @tail
    temp.next = new_link
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        return link.val
      end
    end
    nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
