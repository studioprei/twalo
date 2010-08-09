require "sinatra/base"

module Twalo
  class App < Sinatra::Base
    get '/' do
      "Twallo"
    end
  end
end