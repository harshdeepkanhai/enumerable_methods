# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |elem| arr.push(elem) if yield(elem) }
    arr
  end

  def my_all?(param = nil)
    return include?(nil) || include?(false) ? false : true if param.nil? && !block_given?

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
    if param.nil? && !block_given?
      my_each { |elem| return true if elem }
      return false
    elsif param.is_a? Regexp
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
    if !block_given? && param.nil?
      my_each { |elem| return false unless elem.nil? || elem == false }
    elsif param.is_a? Regexp
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
    return size if !block_given? && param.nil?

    count = 0
    if block_given?
      my_each { |elem| count += 1 if yield(elem) }
    else
      my_each { |elem| count += 1 if elem == param }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    arr = []
    my_each { |elem| proc.nil? ? arr.push(yield(elem)) : arr.push(proc.call(elem)) }
    arr
  end

  def my_inject(accumulator = nil, sym = nil)
    if (!accumulator.nil? && sym.nil?) && (accumulator.is_a?(Symbol) || accumulator.is_a?(String))
      sym = accumulator
      accumulator = nil
    end

    if !block_given? and !sym.nil?
      my_each { |elem| accumulator = accumulator.nil? ? elem : accumulator.send(sym, elem) }
    elsif block_given?
      my_each { |elem| accumulator = accumulator.nil? ? elem : yield(accumulator, elem) }
    else
      raise LocalJumpError
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |accum, i| accum * i }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
