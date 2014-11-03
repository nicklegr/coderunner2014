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

loop do
  info = get_info
  room = info["you"]["room"]


  # max
  history = info["history"].sort_by do |e|
    e["damage"]
  end
  history.reverse!
  # puts history

  max_attack = history.first


  # sort
  history = info["history"].sort_by do |e|
    e["skill"]
  end

  skill = -1
  skills = (0..99).to_a
  prev_skills = info["history"].map do |e| e["skill"] end
  not_used_skills = skills - prev_skills

  puts not_used_skills.join(" ")


  # attack
  skill = 
    if max_attack && max_attack["damage"] >= 500
      max_attack["skill"]
    else
      not_used_skills.first
    end

  score = check(skill)

  puts "#{room} #{score} #{skill}"


  last_room = room
  skill += 1

  sleep 0.8
end
