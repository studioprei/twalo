require "restclient"
require "rack"
require "json"

require_relative "../spec/fixtures"

require "dm-rest-adapter"

DataMapper.setup(:twitter, {
 :adapter  => 'rest',
 :format   => 'json',
 :host     => 'localhost',
 :port     => 9393,
 # :login    => 'user',
 # :password => 'verys3crit'
})

repository(:twitter) do
  puts Tweet.all
end


# 
# def plot_tags(query, plotted=[])
#   q = Rack::Utils.escape("##{query}")
#   uri = "http://search.twitter.com/search.json?q=#{q}"
#   
#   RestClient.get(uri)
#   
#   # tags = RestClient.get(uri) { |tweet_data| JSON.parse(tweet_data.to_s) }.fetch('results').map { |tweet| 
#   #     tweet['text'].scan(/\#(\w+?)( |$)/).map { |s| 
#   #       s[0].downcase
#   #     }
#   #   }.flatten.uniq
# end
# 
# puts plot_tags('inception')