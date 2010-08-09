require "sinatra/base"
require "haml"

module Twalo
  class App < Sinatra::Base
    
    set :root, File.join(File.dirname(__FILE__), '..')
    set :public, File.join(File.dirname(__FILE__), '..', 'public')
    set :views, File.join(File.dirname(__FILE__), '..', 'views')
      
    get '/' do
      haml :index
    end
  end
end