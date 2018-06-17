def gravitysort(arr)

  arr = [[], arr.map{|i|[1]*i}]

  pass = 1

  until arr[1].all?{|i|i.length==0}
    arr[0].unshift([])
    arr[1].each do |i|
      arr[0][0] << i.pop

    end
    arr[0][0] = arr[0][0].compact
    arr[1].select!{|i|i.length!=0}

    pass += 1
  end

  return arr[0].map(&:length)

end

input = eval open "4096_ints_array.txt",&:read

require "benchmark"

measure = Benchmark.measure { gravitysort(input) }

puts "#{__FILE__}: Benchmark: #{measure}"
