def countingsort(arr)

  indices = {}

  arr.each do |i|
    indices[i] ||= 0
    indices[i] += 1
  end

  addition_arr = []
  indices.each_pair{|k,v|addition_arr[k]=v}
  addition_arr.map!{|i|i||0}

  (addition_arr.length-1).times do |t|
    addition_arr[t+1] += addition_arr[t]
  end

  indices.each_key do |k|
    indices[k]=addition_arr[k]
  end

  sorted_arr = []
  arr.each do |i|
    sorted_arr[indices[i]] = i
    indices[i] -= 1
  end

  return sorted_arr[1..-1]

end

input = eval open "4096_ints_array.txt",&:read

require "benchmark"

measure = Benchmark.measure { countingsort(input) }

puts "#{__FILE__}: Benchmark: #{measure}"
