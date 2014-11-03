require 'open-uri'

TOKEN  = "CD0QCOL172C10A4ZX6N3BLZGC59L7I9X"

def query(url)
  res = open(url)
  res.string
end

def check(req)
  url = "https://game.coderunner.jp/q?token=#{TOKEN}&str=#{req}"
#  puts url
  result = query(url)
  sleep 0.9
  result.to_i
end

list = ARGF.readlines.map do |e|
  arr = e.split(" ")
  [ arr[1].to_i, arr[0] ]
end

list.sort_by! do |a|
  a[0]
end

list.reverse!

strs = []

list.each do |e|
  strs += e[1].split('Z')
end

# puts strs

strs.each do |e|
  puts "#{check(e)} #{e}"
end
