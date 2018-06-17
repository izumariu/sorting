def countingsort(arr)

  phases = ["COUNT", "CALC", "SORT"]
  phase = 0

  logmsg = ->(s){puts("[COUNTINGSORT@#{phases[phase]}] #{s}")}
  logmsg.call "ENTER"

  indices = {}

  arr.each do |i|
    indices[i] ||= 0
    indices[i] += 1
    logmsg.call "NUM=#{i} ; COUNT(NUM)=#{indices[i]}"
  end

  phase += 1

  addition_arr = []
  indices.each_pair{|k,v|addition_arr[k]=v}
  addition_arr.map!{|i|i||0}

  (addition_arr.length-1).times do |t|
    (addition_arr[t+1] != 0) && (logmsg.call "( addition_arr[#{t+1}](=#{addition_arr[t+1]}) += addition_arr[#{t}](=#{addition_arr[t]}) ) = #{addition_arr[t+1] + addition_arr[t]}")
    addition_arr[t+1] += addition_arr[t]
  end

  indices.each_key do |k|
    logmsg.call "indices[#{k}] = addition_arr[#{k}](=#{addition_arr[k]})"
    indices[k]=addition_arr[k]
  end


  phase += 1


  sorted_arr = []
  arr.each do |i|
    logmsg.call "sorted_arr[indices[#{i}]] = #{i} ; indices[#{i}] -= 1"
    sorted_arr[indices[i]] = i
    indices[i] -= 1
  end

  logmsg.call "EXIT"

  return sorted_arr[1..-1]

end

cs_input = Array.new(10){(0..8).to_a.sample}.shuffle
puts "COUNTINGSORT INPUT = #{cs_input.inspect}"

cs_output = countingsort cs_input

puts "COUNTINGSORT OUTPUT = #{cs_output.inspect}"
