list = ARGF.readlines.map do |e|
  arr = e.split(" ")
  [ arr[0].to_i, arr[1] ]
end

list.sort_by! do |a|
  a[0]
end

list.sort_by do |e|
  e[0]
end

list.reverse!

list[0, 7].each do |e|
  puts "#{e[0]} #{e[1]}"
end
