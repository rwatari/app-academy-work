require 'tdd_array'

describe '#my_uniq' do
  it 'returns an array that only contains unique elements' do
    expect([1,2,1,3,3].my_uniq).to eq([1,2,3])
  end

  it 'does not modify the original array' do
    a = [1,2,1,3,3]
    a.my_uniq
    expect(a).to eq([1,2,1,3,3])
  end

  it 'returns the same array if already unique' do
    expect([1,2,3].my_uniq).to eq([1,2,3])
  end
end

describe '#two_sum' do
  subject(:arr) { [-1, 0, 2, -2, 1] }

  it 'returns the pairs of indices where the elements sum to 0' do
    expect(arr.two_sum).to match_array([[0, 4], [2, 3]])
  end

  it 'orders the pairs of indices in dictionary order' do
    expect(arr.two_sum).to eq([[0, 4], [2, 3]])
  end

  it 'returns an empty array if there are no pairs summing to 0' do
    expect([1,2,3].two_sum).to eq([])
  end
end

describe '#my_transpose' do
  let(:matrix) do
    [[0, 1, 2],
     [3, 4, 5],
     [6, 7, 8]]
  end

  it "returns transposed array" do
    expect(matrix.my_transpose).to eq(matrix.transpose)
    expect(matrix.my_transpose2).to eq(matrix.transpose)
  end
end

describe 'Stock Picker' do
  it 'returns the pair of most profitable days to buy and sell' do
    expect(stock_picker([1, 3, 7, 2, 4])).to eq([0, 2])
  end

  it 'returns an empty array if there is no profit' do
    expect(stock_picker([5,4,3,2,1])).to eq([])
  end
end
