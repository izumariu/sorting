def quicksort(arr)

  arr.length >= 2 || (return arr)

  pivot = arr.delete_at rand arr.length
  arr_qs = arr.partition{|i| i < pivot }
  arr_qs.insert(1, [pivot])
  arr_qs[0] = quicksort arr_qs[0]
  arr_qs[2] = quicksort arr_qs[2]

  return arr_qs.flatten

end

qs_input = eval open "4096_ints_array.txt",&:read  #(0..10).to_a.shuffle
# array with numbers 0..10, shuffled

require "benchmark"
qs_output = nil

measure = Benchmark.measure { qs_output = quicksort(qs_input) }
# apply quicksort

puts "#{__FILE__}: Benchmark: #{measure}"
