def radix_lsd(arr)


  digits = arr.max.to_s.length
  arr.map!{|i|sprintf("%0#{digits}d",i)}

  digits.times do |i|

    buckets = Array.new(10){[]}

    until arr == []
      el = arr.shift
      buckets[el[~i].to_i].push(el)
    end

    arr = buckets.flatten

  end

  arr.map!(&:to_i)

  return arr

end

input = eval open "4096_ints_array.txt",&:read

require "benchmark"

measure = Benchmark.measure { radix_lsd(input) }

puts "#{__FILE__}: Benchmark: #{measure}"
