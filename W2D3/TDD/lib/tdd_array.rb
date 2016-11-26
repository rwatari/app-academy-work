class Array
  def my_uniq
    result = []
    each do |el|
      result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []
    i = 0
    while i < length

      j = i + 1
      while j < length
        result << [i, j] if self[i] + self[j] == 0
        j += 1
      end

      i += 1
    end
    result
  end

  def my_transpose
    result = []
    size.times do |row|
      new_row = []
      size.times do |col|
        new_row << self[col][row]
      end

      result << new_row
    end

    result
  end

  def my_transpose2
    (0...length).map { |i| map { |row| row[i] } }
  end
end

def stock_picker(arr)
  best_days = []
  best_profit = 0

  arr.size.times do |sell|
    sell.times do |buy|
      profit = arr[sell] - arr[buy]
      if profit > best_profit
        best_profit = profit
        best_days = buy, sell
      end
    end
  end
  best_days
end
