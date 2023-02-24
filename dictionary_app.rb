require "http"
require "open-uri"
# require "json"

system "clear"

webster = true

while webster == true
  puts "Please enter any word!"
  entry = gets.chomp

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{entry}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=INSERT KEY HERE")

  word_data = response.parse(:json)

  type = word_data[0 || 1]["partOfSpeech"]
  definition = word_data[0 || 1]["text"].downcase

  puts
  puts "The word #{entry} is a #{type} with a definition of #{definition} "

  audio_response = HTTP.get("https://api.wordnik.com/v4/word.json/#{entry}/audio?api_key=INSERT KEY HERE")

  audio_data = audio_response.parse(:json)

  audio_file = audio_data[0]["fileUrl"]

  system("open", audio_file)

  puts
  puts "Pronouncing #{entry}"

  puts
  puts "Would you like to search another? Yes or No?"
  repeat = gets.chomp.downcase

  if repeat == "no"
    webster == false
    puts "Byeeeeee. See you soon!"
    break
  end
end
