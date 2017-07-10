class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
      pivot = array[0]
      left = array.select { |num| num < pivot }
      right = array.select { |num| num > pivot }

      sort1(left) + [pivot] + sort1(right)
    end
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if length <= 1
    piv_idx = partition(array, start, length, &prc)
    left_length = piv_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc)
    sort2!(array, piv_idx + 1, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    piv_idx, pivot = start, array[start]

    ((piv_idx + 1)...(piv_idx + length)).each do |idx|
      if prc.call(array[start], array[idx]) > 0
        array[idx], array[piv_idx + 1] = array[piv_idx + 1], array[idx]
        piv_idx += 1
      end
    end
    array[start], array[piv_idx] = array[piv_idx], array[start]
    piv_idx

end
