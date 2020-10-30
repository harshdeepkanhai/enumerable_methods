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

  def my_all?(param = nil)
    result = true
    if !block_given? && param.nil?
      return result
    elsif param.is_a? Regexp
      i = 0
      while i < length
        unless param.match?(self[i])
          result = false
          break
        end
        i += 1
      end
    elsif param.is_a? Class
      i = 0
      while i < length
        unless self[i].is_a? param
          result = false
          break
        end
        i += 1
      end
    elsif block_given?
      i = 0
      while i < length
        unless yield(self[i])
          result = false
          break
        end
        i += 1
      end
    else
      i = 0
      while i < length
        unless self[i] == param
          result = false
          break
        end
        i += 1
      end
    end

    result
  end

  def my_any?(param = nil)
    result = false
    if !block_given? && param.nil?
      result = true
      return result
    elsif param.is_a? Regexp
      i = 0
      while i < length
        if param.match?(self[i])
          result = true
          break
        end
        i += 1
      end
    elsif param.is_a? Class
      i = 0
      while i < length
        if self[i].is_a? param
          result = true
          break
        end
        i += 1
      end
    elsif block_given?
      i = 0
      while i < length
        if yield(self[i])
          result = true
          break
        end
        i += 1
      end
    else
      i = 0
      while i < length
        if self[i] == param
          result = true
          break
        end
        i += 1
      end
    end
    result
  end

  def my_none?(param = nil)
    result = true
    if !block_given? && param.nil?
      result = false
      return result
    elsif param.is_a? Regexp
      i = 0
      while i < length
        if param.match?(self[i])
          result = false
          break
        end
        i += 1
      end
    elsif param.is_a? Class
      i = 0
      while i < length
        if self[i].is_a? param
          result = false
          break
        end
        i += 1
      end
    elsif block_given?
      i = 0
      while i < length
        if yield(self[i])
          result = false
          break
        end
        i += 1
      end
    else
      i = 0
      while i < length
        if self[i] == param
          result = false
          break
        end
        i += 1
      end
    end
    result
  end

  def my_count(param = nil)
    return length if !(block_given?) && param.nil?
    if block_given?
      count = 0
      i = 0
      while i < length
        count += 1 if yield(self[i])
        i += 1
      end
    else 
      count = 0
      i = 0
      while i < length
        count += 1 if self[i] == param
        i += 1
      end
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

  def my_inject(param = nil)
    if param.nil?
      result = self[0]
      i = 1
    else
      result = param
      i = 0
    end

    if !(param.nil?) && !(is_a?(Range))
      while i < length 
        result = yield(result, self[i])
        i += 1
      end
    elsif block_given? && !(is_a?(Range))
      while i < length
        result = yield(result, self[i])
        i += 1
      end
    elsif is_a? Range
      while i < to_a.length
        result = yield(result, self.to_a[i])
        i += 1
      end
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |accum, i| accum * i }
end
