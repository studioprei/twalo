require "dm-core"
require "dm-migrations"
require "dm-sweatshop"
require "dm-serializer"
require "dm-sqlite-adapter"

# Example tweet
#
# {
#   "profile_image_url": "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
#   "created_at": "Mon, 09 Aug 2010 19:38:12 +0000",
#   "from_user": "TwitterUser",
#   "metadata": {
#       "result_type": "recent"
#   },
#   "to_user_id": null,
#   "text": "A tweet with some tags #foo #bar",
#   "id": 1000000000,
#   "from_user_id": 1000000000,
#   "geo": null,
#   "iso_language_code": "en",
#   "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
# }

class Tweet
  include DataMapper::Resource
  
  property :id, Serial
  property :profile_image_url, String
  property :created_at, Date
  property :from_user, String
  property :to_user_id, String
  property :text, Text, :lazy => false
  property :from_user_id, String
  property :geo, String
  property :iso_language_code, String
  property :source, String
end

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Tweet.fix {{
  :profile_image_url => "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
  :created_at => Date.new,
  :from_user => (username = /\w+/.gen),
  :to_user_id => /\w+/.gen,
  :text => /[:sentence:]/.gen[0..140],
  :from_user_id => /\w+/.gen,
  :geo => nil,
  :iso_language_code => "en",
  :source => "source"
}}