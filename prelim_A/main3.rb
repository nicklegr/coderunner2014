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

probs = [
  0.3,
  0.2,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.0,
  0.0,
  0.0,
]



olds = []

10.times do
  gene = []
  50.times do
    gene << arr.sample
  end
  olds << gene.join
end

olds = olds.map do |e|
  [ check(e), e ]
end

olds.each do |e|
  puts "#{e[0]} #{e[1]}"
end

puts "----"





loop do
  olds.sort_by! do |a| a[0] end
  olds.reverse!

  news = []

  while news.size < 10
    pr = Random.rand()
    if pr < 0.995
      # intersection
      n1 = nil
      n2 = nil

      dice = Random.rand()
      index = 0
      sum = 0.0
      probs.each do |e|
        if sum <= dice && dice <= sum + e
          n1 = olds[index]
          break
        end
        sum += e
        index += 1
      end

      dice = Random.rand()
      index = 0
      sum = 0.0
      probs.each do |e|
        if sum <= dice && dice <= sum + e
          n2 = olds[index]
          break
        end
        sum += e
        index += 1
      end

      i1 = Random.rand(50)
      i2 = Random.rand(50)
      first = [ i1, i2 ].min
      second = [ i1, i2 ].max

puts first, second
      str1 = n1[1][0, first] +
        n2[1][first, second-first] +
        n1[1][second, 100]

      str2 = n2[1][0, first] +
        n1[1][first, second-first] +
        n2[1][second, 100]

puts "======"
puts str1
puts str2

      news << [ check(str1), str1 ]
      news << [ check(str2), str2 ]
    else
      str = olds.sample[1]
      pi = Random.rand(50)
      str[pi] = arr.sample

      news << [ check(str), str.dup ]
#      puts "++++++"
#      puts str
    end
  end

  news = news[0, 10]

  news.each do |e|
    puts "#{e[0]} #{e[1]}"
  end

  puts "----------"

  olds = news
end
