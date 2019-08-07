class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |e, i|
      sum ^= (e ^ i).to_s(2).to_i.hash
    end
    sum
  end
end

class String
  def hash
    split('').map(&:hex).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.to_s.hash
  end
end

hash = {lol: 1, wat: 2}
hash2 = {wat: 2, lol: 1}
options = { font_size: 10, font_family: "Arial" }
p hash.hash
p options.hash
p hash2.hash

