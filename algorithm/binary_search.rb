class BinarySearch
   attr_accessor :keys
   
   def rank(key)
      lo = 0
      hi = keys.size - 1
      while (lo <= hi)
         m = lo + (hi-lo)/2
         if key < keys[m]
            hi = m - 1
         elsif key > keys[m]
            lo = m + 1
         else
            return m
         end
      end
      return lo         
   end
   
   def ceil(key)
      i = rank(key)
      return nil if i == keys.size
      return keys[i]
   end
   
   def floor(key)
      i = rank(key)
      if i == 0
         return nil 
      elif (i < key.size && key == keys[i])
         return keys[i] 
      else
         return keys[i-1]
      end      
   end
   
   def insert(key)
      i = rank(key)
      keys.insert(i, key) if key != keys[i]         
      self
   end
end

bs = BinarySearch.new
bs.keys = ['a', 'c', 'e', 'g']

('a'...'i').each do |alpha|
   puts "rank of #{alpha}: #{bs.rank alpha}"
   puts "floor of #{alpha}: #{bs.floor alpha}"
   puts "ceiling of #{alpha}: #{bs.ceil alpha}"
   puts '-' * 36
end

p bs.insert('b').insert('d').insert('f').keys
