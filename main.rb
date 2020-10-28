module Enumerable
  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    arr = []
    i = 0
    while i < length
      arr.push(self[i]) if yield(self[i])
      i += 1
    end
    arr
  end

  def my_all?
    result = true
    i = 0
    while i < length
      unless yield(self[i])
        result = false
        break
      end
      i += 1
    end
    result
  end

  def my_any?
    result = false
    i = 0
    while i < length
      if yield(self[i])
        result = true
        break
      end
      i += 1
    end
    result
  end

  def my_none?
    result = true
    i = 0
    while i < length
      if yield(self[i])
        result = false
        break
      end
      i += 1
    end
    result
  end

  def my_count
    return length unless block_given?

    count = 0
    i = 0
    while i < length
      count += 1 if yield(self[i])
      i += 1
    end
    count
  end
end

ary = [1, 2, 4, 2]

p ary.my_count
p ary.my_count(&:even?)
