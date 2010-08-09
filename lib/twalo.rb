require "sinatra/base"
require "haml"

module Twalo
  class App < Sinatra::Base
    get '/' do
      haml :index
    end
  end
end