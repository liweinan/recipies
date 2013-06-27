# http://www.dzone.com/snippets/shuffling-array-ruby
class Array
  def shuffle!
    size.downto(1) { |n| push delete_at(rand(n)) }
    self
  end
end

#http://opennfo.wordpress.com/2009/02/15/quicksort-in-ruby/
def quicksort(list, p, r)
    if p < r then
        q = partition(list, p, r)
        quicksort(list, p, q-1)
        quicksort(list, q+1, r)
    end
end
 
def partition(list, p, r)
    pivot = list[r]
    i = p - 1
    p.upto(r-1) do |j|
        if list[j] <= pivot
            i = i+1
            list[i],list[j] = list[j],list[i]
        end       
    end
    list[i+1],list[r] = list[r],list[i+1]
    return i + 1
end
 
# Testing it out
a = [1,2,3,4,5,6,7,8,9]
a.shuffle!

quicksort(a, 0, a.length-1)
puts a.inspect