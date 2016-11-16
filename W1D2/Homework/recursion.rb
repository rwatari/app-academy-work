def sum_to(n)
  # calculates the sum of 1 ... n inclusive
  if n <= 0
    nil
  elsif n == 1
    1
  else
    n + sum_to(n - 1)
  end
end

def add_numbers(nums_array = nil)
  # calculates the sum of the numbers in the array
  return nil unless nums_array.is_a?(Array)

  nums_array.empty? ? 0 : nums_array[0] + add_numbers(nums_array[1..-1])
end

def gamma_fnc(n)
  return nil if n < 1

  n == 1 ? 1 : (n - 1) * gamma_fnc(n - 1)
end
