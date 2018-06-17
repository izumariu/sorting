def heapsort(arr)

  logmsg = ->(s,n=nil){puts("[HEAPSORT#{n ? "@N:#{n}" : ""}] #{s}")}

  # those lambdas make it possible to build a heap
  # and still maintain a 1D array shape
  heap_children_offset      = ->(i)  { 2*i+1 }
  heap_parent               = ->(i)  { (i-((i+1)%2)-1)/2 }
  broken_heapprop           = ->(i,c){ c.all?{|child|i>=child} == false }

  sift_down_if_needed = lambda do |parent_i,_arr,check=true|
    enter_pi = parent_i # only used for logmsg
    sift_needed = false # only used for logmsg
    loop do
      parent     = _arr[parent_i]
      children_o = heap_children_offset.call(parent_i)
      children   = _arr.values_at(children_o, children_o+1).select{|i|i!=nil}
      break if children==[]
      children_mi= children_o + children.index(children.max)
      break unless broken_heapprop.call(parent, children)
      sift_needed = true
      logmsg.call("SIFT DOWN: heap[#{parent_i}](=#{_arr[parent_i]}) <=> heap[#{children_mi}](=#{_arr[children_mi]})", check ? enter_pi : nil)
      _arr[parent_i], _arr[children_mi] = [_arr[children_mi], _arr[parent_i]]
      parent_i = children_mi
    end
    sift_needed||(check&&logmsg.call("Node ##{enter_pi} OK",enter_pi))
    _arr
  end

  heapify = lambda do |_arr|
    logmsg.call "ENTER HEAPIFY"
    parent_i = heap_parent.call(_arr.length-1)
    logmsg.call "#{parent_i+1} nodes detected"
    loop do
      logmsg.call("Checking node ##{parent_i}",parent_i)
      _arr = sift_down_if_needed.call(parent_i, _arr)
      break if parent_i == 0
      parent_i -= 1
    end
    logmsg.call "EXIT HEAPIFY"
    _arr
  end

  logmsg.call "ENTER"

  heap = Array.new heapify.call(arr) ; arr.clear

  until heap == []
    arr.unshift heap.shift # unshift the top element of the heap into the array
    logmsg.call "#{heap.inspect} =(#{arr[0]})=> #{arr.inspect}"
    heap.unshift heap.pop # put the last heap element on top...
    logmsg.call "Putting last element of heap on top: #{heap.inspect}"
    if heap.length == 1
      arr.unshift heap.shift # unshift the top element of the heap into the array
      logmsg.call "#{heap.inspect} =(#{arr[0]})=> #{arr.inspect}"
    else
      heap = sift_down_if_needed.call(0, heap, false)
    end
  end

  logmsg.call "EXIT"

  return arr

end

hs_input = (0..256).to_a.shuffle
puts "HEAPSORT INPUT = #{hs_input.inspect}"

hs_output = heapsort hs_input

puts "HEAPSORT OUTPUT = #{hs_output.inspect}"
