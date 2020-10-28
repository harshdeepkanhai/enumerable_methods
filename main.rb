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
end