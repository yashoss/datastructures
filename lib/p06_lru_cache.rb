require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

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
    if @map[key] != nil
      update_link!(key)
    else
      val = calc!(key)
      if @map.count > @max
        eject!
      end
    end
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.insert(key, val)
    @map[key] = @store.last
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    val = @map[link].val
    @store.insert(link, val)
    @map[link] = @store.last
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first)
  end
end
