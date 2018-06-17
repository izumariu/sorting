def radix_lsd(arr)

  logmsg = ->(s,pass=nil){puts("[RADIX_LSD#{pass ? ":#{pass}" : ""}] #{s}")}
  logmsg.call "ENTER"

  digits = arr.max.to_s.length
  logmsg.call "Maximum of array has #{digits} digits, mapping all other elements to have #{digits} digits with preceeding zeroes"
  arr.map!{|i|sprintf("%0#{digits}d",i)}

  digits.times do |i|

    logmsg.call "ASSIGNING PHASE", i+1
    buckets = Array.new(10){[]}

    until arr == []
      el = arr.shift
      logmsg.call "#{el} belongs in bucket ##{el[~i].to_i}", i+1
      buckets[el[~i].to_i].push(el)
    end

    logmsg.call "COLLECTION PHASE", i+1
    arr = buckets.flatten

    logmsg.call "Result of pass #{i+1}: #{arr.inspect}"

  end

  logmsg.call "Mapping all elements back to integers"
  arr.map!(&:to_i)
  logmsg.call "EXIT"

  return arr

end

rds_input = (0..100).to_a.shuffle
puts "RADIX LSD INPUT: #{rds_input.inspect}"

rds_output= radix_lsd rds_input

puts "RADIX LSD OUTPUT: #{rds_output.inspect}"
