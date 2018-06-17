def quicksort(arr, depth=0)

  logmsg = ->(s){puts("[QUICKSORT:#{depth}] #{s}")}

  logmsg.call "ENTER"

  arr.length >= 2 || (logmsg.call("Array is too small to be unsorted");logmsg.call("EXIT");return arr)

  pivot = arr.delete_at rand arr.length
  arr_qs = arr.partition{|i| i < pivot }
  arr_qs.insert(1, [pivot])
  logmsg.call "arr_qs = #{arr_qs.inspect} | Now sorting arr_qs[0] and arr_qs[2]"
  arr_qs[0] = quicksort arr_qs[0], depth+1
  arr_qs[2] = quicksort arr_qs[2], depth+1

  logmsg.call "EXIT"

  return arr_qs.flatten

end

qs_input = (0..10).to_a.shuffle
# array with numbers 0..10, shuffled

puts "INPUT ARRAY: #{qs_input.inspect}"

qs_output = quicksort(qs_input)
# apply quicksort

puts "OUTPUT ARRAY: #{qs_output.inspect}"
