def heapsort(arr)

  # those lambdas make it possible to build a heap
  # and still maintain a 1D array shape
  heap_children_offset      = ->(i)  { 2*i+1 }
  heap_parent               = ->(i)  { (i-((i+1)%2)-1)/2 }
  broken_heapprop           = ->(i,c){ c.all?{|child|i>=child} == false }

  sift_down_if_needed = lambda do |parent_i,_arr,check=true|
    loop do
      parent     = _arr[parent_i]
      children_o = heap_children_offset.call(parent_i)
      children   = _arr.values_at(children_o, children_o+1).select{|i|i!=nil}
      break if children==[]
      children_mi= children_o + children.index(children.max)
      break unless broken_heapprop.call(parent, children)
      sift_needed = true
      _arr[parent_i], _arr[children_mi] = [_arr[children_mi], _arr[parent_i]]
      parent_i = children_mi
    end
    _arr
  end

  heapify = lambda do |_arr|
    parent_i = heap_parent.call(_arr.length-1)
    loop do
      _arr = sift_down_if_needed.call(parent_i, _arr)
      break if parent_i == 0
      parent_i -= 1
    end
    _arr
  end

  heap = Array.new heapify.call(arr) ; arr.clear

  until heap == []
    arr.unshift heap.shift # unshift the top element of the heap into the array
    heap.unshift heap.pop # put the last heap element on top...
    if heap.length == 1
      arr.unshift heap.shift # unshift the top element of the heap into the array
    else
      heap = sift_down_if_needed.call(0, heap, false)
    end
  end

  return arr

end

input = eval open "4096_ints_array.txt",&:read

require "benchmark"

measure = Benchmark.measure { heapsort(input) }

puts "#{__FILE__}: Benchmark: #{measure}"
