module ShellSort
  def self.sort(keys)
    sort!(keys.clone)
  end
 
  def self.sort!(keys)
    gap = keys.size/2
    while gap > 0 # extra loop compared with InsertionSort
      for i in gap...keys.size
        key = keys[i]
        j = i
        while (j >= gap and keys[j-gap] > key)
          keys[j] = keys[j-gap]
          j -= gap
        end
        keys[j] = key
      end
      gap /= 2
    end
    keys
  end
end

module InsertionSort
    def self.sort(keys)
        sort!(keys.clone)
    end

    def self.sort!(keys)
        for i in 1...keys.size
            key = keys[i]
            j = i
            while (j >= 1 and keys[j-1] > key)
                keys[j] = keys[j-1] 
                j -= 1
            end
            keys[j] = key
        end
        keys
    end
end

module MergeSort
    def self.sort(list)
        mergesort(list)
    end
    
    def self.mergesort(list)
      return list if list.size <= 1
      mid = list.size / 2
      left  = list[0, mid]
      right = list[mid, list.size-mid]
      merge(mergesort(left), mergesort(right))
    end
 
    def self.merge(left, right)
      sorted = []
      until left.empty? or right.empty?
        if left.first <= right.first
          sorted << left.shift
        else
          sorted << right.shift
        end
      end
      sorted.concat(left).concat(right)
    end
end

module QuickSort
  def self.sort(keys)
    quick(keys,0,keys.size-1)
  end
 
  private
 
  def self.quick(keys, left, right)
    if left < right
      pivot = partition(keys, left, right)
      quick(keys, left, pivot-1)
      quick(keys, pivot+1, right)
    end
    keys
  end
 
  def self.partition(keys, left, right)
    x = keys[right]
    i = left-1
    for j in left..right-1
      if keys[j] <= x
        i += 1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[i+1], keys[right] = keys[right], keys[i+1]
    i+1
  end
end

arr = [1, 3, 2, 7, 6, 4, 5]

["ShellSort",  "InsertionSort", "MergeSort", "QuickSort"].each do |klass_name|
    eval "p #{klass_name}.sort(arr)"
end
