require 'pp'

hist = {}

files = Dir.glob("room/*.txt")
files.sort!

maxs = []

files.each do |f|
  arr = []

  File.readlines(f).each do |line|
    arr << line.split.map do |e1| e1.to_i end
    # pp arr
  end

  max_attack = arr.max_by do |e|
    e[1]
  end

  if max_attack[1] >= 10000
    maxs << [ f ] + max_attack
  end


  types = arr.map{|e| e[1]}.sort.uniq

  #pp f
  #pp types
end

maxs.sort_by! do |e|
  e[1]
end

maxs.each do |e|
  puts "#{e[0]} #{e[1]} #{e[2]}"
end

# puts strs

__END__

  min_damage = arr.map{|e| e[1]}.select{|e| e != 0}.min
  max_damage = arr.map{|e| e[1]}.select{|e| e != 0}.max

puts min_damage
puts max_damage

