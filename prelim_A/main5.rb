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

arr = %w|A B C D|

loop do
  gene = []
  50.times do
    gene << arr.sample
  end
  str = gene.join

  puts "#{check(str)} #{str}"
end
