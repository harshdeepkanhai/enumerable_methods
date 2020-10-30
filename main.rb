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

  def my_map(proc = nil)
    arr = []
    i = 0
    while i < length
      proc.nil? ? arr.push(yield(self[i])) : arr.push(proc.call(self[i]))
      i += 1
    end
    arr
  end

  def my_inject
    result = self[0]
    i = 1
    while i < length
      result = yield(result, self[i])
      i += 1
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |accum, i| accum * i }
end
