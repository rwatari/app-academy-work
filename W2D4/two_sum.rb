def bad_sum?(arr, target)
  arr.each_index do |i_1|
    i_1.times do |i_2|
      return true if arr[i_1] + arr[i_2] == target
    end
  end

  false
end

def okay_two_sum?(arr, target)
  sorted = arr.sort

  sorted.any? do |el|
    next if target == 2 * el
    binary_search(sorted, target - el)
  end
end

def binary_search(arr, target)
  return false if arr.empty?

  middle_idx = arr.size / 2
  case arr[middle_idx] <=> target
  when 0
    true
  when 1
    binary_search(arr[0...middle_idx], target)
  when -1
    binary_search(arr[middle_idx + 1..-1], target)
  end
end

def pair_sum?(arr, target)
  nums_hash = Hash.new(false)
  arr.each {|el| nums_hash[el] = true}
  arr.any? do |el|
    next if target == 2 * el
    nums_hash[target - el]
  end 
end
