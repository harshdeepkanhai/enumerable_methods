# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

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
    my_each { |elem| arr.push(elem) if yield(elem) }
    arr
  end

  def my_all?(param = nil)
    return true if !block_given? && param.nil?

    if param.is_a? Regexp
      my_each { |elem| return false unless param.match?(elem) }
    elsif param.is_a? Class
      my_each { |elem| return false unless elem.is_a?(param) }
    elsif block_given?
      my_each { |elem| return false unless yield(elem) }
    else
      my_each { |elem| return false unless elem == param }
    end
    true
  end

  def my_any?(param = nil)
    return true if !block_given? && param.nil?

    if param.is_a? Regexp
      my_each { |elem| return true if param.match?(elem) }
    elsif param.is_a? Class
      my_each { |elem| return true if elem.is_a?(param) }
    elsif block_given?
      my_each { |elem| return true if yield(elem) }
    else
      my_each { |elem| return true if elem == param }
    end
    false
  end

  def my_none?(param = nil)
    return false if !block_given? && param.nil?

    if param.is_a? Regexp
      my_each { |elem| return false if param.match?(elem) }
    elsif param.is_a? Class
      my_each { |elem| return false if elem.is_a?(param) }
    elsif block_given?
      my_each { |elem| return false if yield(elem) }
    else
      my_each { |elem| return false if elem == param }
    end
    true
  end

  def my_count(param = nil)
    return length if !block_given? && param.nil?

    count = 0
    if block_given?
      my_each { |elem| count += 1 if yield(elem) }
    else
      my_each { |elem| count += 1 if elem == param }
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

  def my_inject(accumulator = nil, sym = nil)
    if (!accumulator.nil? && sym.nil?) && (accumulator.is_a?(Symbol) || accumulator.is_a?(String))
      sym = accumulator
      accumulator = nil
    end

    if !block_given? and !sym.nil?
      i = 0
      while i < size
        accumulator = accumulator.nil? ? to_a[i] : accumulator.send(sym, to_a[i])
        i += 1
      end
    elsif block_given?
      i = 0
      while i < size
        accumulator = accumulator.nil? ? to_a[i] : yield(accumulator, to_a[i])
        i += 1
      end
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |accum, i| accum * i }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
