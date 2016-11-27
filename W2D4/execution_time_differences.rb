def my_min(array)
  array.each do |el|
    return el if array.all? {|el2| el <= el2 }
  end
end

def my_min_2(array)
  min = nil
  array.each do |el|
    min = el if min.nil? || el < min
  end
  min
end

def largest_contiguous_subsum(array)
  subsets = []

  array.each_index do |last|
    0.upto(last) do |start|
      subsets << array[start..last]
    end
  end

  max = nil

  subsets.each do |subset|
    sum = subset.inject(:+)
    max = sum if max.nil? || sum > max
  end

  max
end

def largest_contiguous_subsum_2(array)
  result = nil
  sum = 0
  array.each do |el|
    sum += el
    result = sum if result.nil? || sum > result
    sum = 0 if sum < 0
  end

  result
end
