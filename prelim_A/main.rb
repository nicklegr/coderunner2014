require 'open-uri'

def query(url)
  res = open(url)
  res.string
end

list = %q|
|

token  = "CD0QCOL172C10A4ZX6N3BLZGC59L7I9X"

str = "AAAAAAA"

l = ["A","B","C","D"]

ind = [0,0,0,0,0,0,0]
reqs = []

loop do
  for i in 0..6
    if ind[i] == 4
      ind[i+1] += 1 if i < ind.size-1
      ind[i] = 0
    end
  end

  cs = ind.map do |e|
    l[e]
  end

  str = cs.join('')

  reqs << str

  if reqs.size == 6
    req = reqs.join("Z")
    #puts req

    url = "https://game.coderunner.jp/q?token=#{token}&str=#{req}"
    result = query(url)
    puts "#{req} #{result}"

    sleep 1
    reqs = []
  end

  ind[0] += 1
end

__END__

loop do
  a1 = str.dup
  a2 = str.succ!.dup
  a3 = str.succ!.dup
  a4 = str.succ!.dup
  a5 = str.succ!.dup
  a6 = str.succ!.dup
  str.succ!

  req = "#{a1}Z#{a2}Z#{a3}Z#{a4}Z#{a5}Z#{a6}"

  url    = "https://game.coderunner.jp/q?token=#{token}&str=#{req}"
  result = query(url)
  puts "#{req} #{result}"

  sleep 1
end
