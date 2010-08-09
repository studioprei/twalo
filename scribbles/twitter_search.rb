require "restclient"
require "rack"
require "json"


def plot_tags(query, plotted=[])
  q = Rack::Utils.escape("##{query}")
  uri = "http://search.twitter.com/search.json?q=#{q}"
  
  tags = RestClient.get(uri) { |tweet_data| JSON.parse(tweet_data.to_s) }.fetch('results').map { |tweet| 
    tweet['text'].scan(/\#(\w+?)( |$)/).map { |s| 
      s[0].downcase
    }
  }.flatten.uniq
end

puts plot_tags('inception')