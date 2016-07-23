class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    retu_value = 0
    self.each_with_index do |el, idx|
      if el.is_a?(Array)
        retu_value += rand(el.hash ^ retu_value)
      else
        retu_value += el.hash ^ idx
      end
    end
    retu_value
  end
end

class String
  def hash
    idx = 0
    retu_value = 0
    self.each_char do |char|
      retu_value += char.ord ^ idx
      idx += 1
    end
    retu_value
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    retu_value = 0
    self.each do |k, v|
      retu_value += k.hash
    end
    retu_value
  end
end
