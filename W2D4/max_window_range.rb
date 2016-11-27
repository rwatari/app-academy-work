def max_window_range(array, window_size)
  current_max_range = nil

  (array.size - window_size + 1).times do |i|
    window = array[i...i + window_size]
    max = nil
    min = nil

    window.each do |el|
      max = el if max.nil? || el > max
      min = el if min.nil? || el < min
    end

    if current_max_range.nil? || current_max_range < max - min
      current_max_range = max - min
    end
  end

  current_max_range
end
