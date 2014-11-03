require 'open-uri'
require 'json'

TOKEN  = "CDD19ZU6RPS8CJWFNC4T5SOHBU9WZVCD"

def query(url)
  res = open(url)
  res.read
end

def get_info
  url = "https://game.coderunner.jp/info?token=#{TOKEN}"
  result = query(url)
  JSON.parse(result)
end

def check(req)
  url = "https://game.coderunner.jp/attack?token=#{TOKEN}&skill=#{req}"
#  puts url
  result = query(url)
  result.to_i
end

last_room = -1
skill = 0

loop do
  info = get_info
  room = info["you"]["room"]

  if room != last_room
    skill = 0
  end

  history = info["history"].sort_by do |e|
    e["damage"]
  end
  history.reverse!
  # puts history

  max_attack = history.first

  skill = 
    if max_attack && max_attack["damage"] >= 500
      max_attack["skill"]
    else
      skill # Random.rand(100)
    end

  score = check(skill)

  puts "#{room} #{score} #{skill}"


  last_room = room
  skill += 1

  sleep 0.8
end
