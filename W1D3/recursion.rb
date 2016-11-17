require 'byebug'

def range(start, finish)
  return [] if start > finish
  return [start] if start == finish

  [start] + range(start + 1, finish)
end

def sum_array(arr)
  return nil unless arr.is_a?(Array)
  return 0 if arr.empty?

  return arr.first if arr.length == 1

  arr.first + sum_array(arr[1..-1])
end

def sum_array_it(arr)
  sum = 0
  arr.each { |el| sum += el }
  sum
end

def exp1(base, ex)
  return 1 if ex.zero?

  base * exp1(base, ex - 1)
end

def exp2(base, ex)
  return 1 if ex.zero?

  if ex.even?
    rt_sqr = exp2(base, ex / 2)
    rt_sqr * rt_sqr
  else
    rt_sqr = exp2(base, (ex - 1) / 2)
    base * rt_sqr * rt_sqr
  end
end

def deep_dup(arr)
  return arr.dup if arr.none? { |el| el.is_a?(Array) }

  result = []
  arr.each do |el|
    result << (el.is_a?(Array) ? deep_dup(el) : el)
  end

  result
end

def fib(n)
  return [1, 1].take(n) if n <= 2
  prev_fib = fib(n - 1)
  prev_fib << prev_fib[-2] + prev_fib[-1]
end

def permutations(arr)
  return [arr] if arr.size == 1

  last = arr.pop
  result = []
  permutations(arr).each do |sub_array|
    0.upto(sub_array.size) do |i|
      result << sub_array.dup.insert(i, last)
    end
  end

  result
end

def binary_search(array, target)
  return nil if array.size == 1 && target != array[0]

  idx = array.size / 2
  if array[idx] == target
    idx
  elsif array[idx] > target
    result = binary_search(array[0...idx], target)
    return nil if result.nil?
    result
  else
    result = binary_search(array[(idx + 1)..-1], target)
    return nil if result.nil?
    idx + result + 1
  end
end

def merge_sort(arr)
  length = arr.length

  return arr if length <= 1

  first_half = merge_sort(arr.take(length / 2))
  second_half = merge_sort(arr.drop(length / 2))

  merge_helper(first_half, second_half)
end

def merge_helper(arr_1, arr_2)
  result = []

  until arr_1.empty? && arr_2.empty?
    if arr_1.empty?
      result << arr_2.shift
    elsif arr_2.empty?
      result << arr_1.shift
    elsif arr_1.first < arr_2.first
      result << arr_1.shift
    else
      result << arr_2.shift
    end
  end

  result
end

# def subsets(arr)
#   return [arr] if arr.empty?
#
#   last = arr.pop
#   sub_subsets = subsets(arr)
#   result = []
#
#   sub_subsets.each do |sub_arr|
#     result << sub_arr.dup
#     sub_arr << last
#     result << sub_arr
#   end
#
#   result
# end

def subsets(arr)
  return [arr] if arr.empty?

  last = arr.pop
  sub_subsets = subsets(arr)

  sub_subsets + sub_subsets.map do |sub_arr|
    sub_arr.dup << last
  end
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  coins.sort!.reverse!

  return [amount] if coins.include?(amount)

  big_coin = coins.find { |coin| coin < amount }

  [big_coin] + greedy_make_change(amount - big_coin, coins)
end

def make_change(amount, coins = [25, 10, 5, 1])
  coins.sort!.reverse!.select! { |coin| coin <= amount }

  return [amount] if coins.include?(amount)

  solution = nil

  coins.each do |coin|
    poss_coins = coins.select { |cur_coin| cur_coin <= coin }
    var = [coin] + make_change((amount - coin), poss_coins)
    solution = var if solution.nil? || (var.length < solution.length)
  end

  solution
end

def includes?(arr, target)
  return false if arr.empty?
  return true if arr.first == target

  current = arr.shift
  includes?(arr, target)
end

def num_occur(arr, target)
  return 0 if arr.length ==1 && arr.first != target
  return 1 if arr.shift == target
end

def num_occur(arr, target)
  return 0 if arr.empty?

  if arr.shift == target
    1 + num_occur(arr, target)
  else
    num_occur(arr, target)
  end
end
