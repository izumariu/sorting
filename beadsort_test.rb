def gravitysort(arr)

  logmsg = ->(s,pass=nil){puts("[GRAVITYSORT#{pass ? ":#{pass}" : ""}] #{s}")}
  logmsg.call "ENTER"

  logmsg.call "Converting array into Abacus form"
  arr = [[], arr.map{|i|[1]*i}]

  pass = 1

  logmsg.call("Sorting...")

  until arr[1].all?{|i|i.length==0}
    arr[0].unshift([])
    arr[1].each do |i|
      arr[0][0] << i.pop
    end
    arr[0][0] = arr[0][0].compact
    arr[1].select!{|i|i.length!=0}

    oarr = Array.new(arr)
    oarr[0] = oarr[0].map(&:length)
    oarr[1] = oarr[1].map(&:length)
    oarr = oarr.flatten
    logmsg.call oarr.inspect, pass

    pass += 1
  end

  return arr[0].map(&:length)

end

gs_input = (0..10).to_a.shuffle
puts "GRAVITYSORT INPUT = #{gs_input.inspect}"

gs_output = gravitysort(gs_input)

puts "GRAVITYSORT OUTPUT = #{gs_output.inspect}"
