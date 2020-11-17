require_relative '../lib/enumerables'

describe Enumerable do
  describe '#my_each' do
    it 'returns itself with block' do
      expect([2, 3, 4, 5].my_each { |x| x + 2 }).to eql([2, 3, 4, 5])
    end
    it 'returns an enumerator with no block' do
      expect([2, 3, 4, 5].my_each).to be_a(Enumerator)
    end
  end
  describe '#my_each_with_index' do
    it 'returns itself with block' do
      expect([2, 3, 4, 5].my_each_with_index { |x, i| x + i }).to eql([2, 3, 4, 5])
    end
    it 'returns an enumerator with no block' do
      expect([2, 3, 4, 5].my_each_with_index).to be_a(Enumerator)
    end
  end
  describe '#my_select' do
    it 'filters the value' do
      expect([2, 3, 4, 5].my_select { |x| x > 3 }).to eql([4, 5])
    end
  end
  describe '#my_all?' do
    it 'returns true for all cases are true' do
      expect([2, 3, 4, 5].my_all? { |x| x > 0 }).to be true
    end
    it 'returns false for single false case' do
      expect([2, 3, 4, 5].my_all? { |x| x > 2 }).to be false
    end
  end
  describe '#my_any?' do
    it 'returns true for any one value gives true' do
      expect([2, 3, 4, 5].my_any? { |x| x > 4 }).to be true
    end
    it 'returns false for all false case' do
      expect([2, 3, 4, 5].my_all? { |x| x < 0 }).to be false
    end
  end
  describe '#my_none?' do
    it 'returns true if none of the condition matches' do
      expect([2, 3, 4, 5].my_none? { |x| x < 0 }).to be true
    end
    it 'returns false if  the condition matches' do
      expect([2, 3, 4, 5].my_none? { |x| x > 2 }).to be false
    end
  end
  describe '#my_count' do
    it 'returns  length according to the condition given' do
      expect([2, 3, 4, 5].my_count { |x| x > 2 }).to eql(3)
    end
    it 'returns total length if no condition given' do
      expect([2, 3, 4, 5].my_count).to eql(4)
    end
  end
  describe '#my_map' do
    it 'returns new values with map according to block passed' do
      expect([2, 3, 4, 5].my_map { |x| x + 2 }).to eql([4, 5, 6, 7])
    end
    it 'returns new values with map according to Proc passed' do
      power = proc { |x| x**2 }
      expect([2, 3, 4, 5].my_map(&power)).to eql([4, 9, 16, 25])
    end
  end
  describe '#my_inject' do
    it 'returns multiple of all values if * symbol passed' do
      expect([2, 3, 4, 5].my_inject(:*)).to eql(120)
    end
    it 'returns total with accumulator passed' do
      expect([2, 3, 4, 5].my_inject { |accumulator, elem| accumulator + elem }).to eql(14)
    end
  end
  describe '#multiply_els' do
    it 'returns multiple of all values if * symbol passed' do
      expect(multiply_els([10,20,30,40])).to eql(240000)
    end
  end
end
