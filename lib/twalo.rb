require "sinatra/base"
require "haml"
require "sass"
require "json"

module Twalo
  class TagParser
    def parse(data)
      {}
    end
  end
  
  class App < Sinatra::Base
        
    set :root, File.join(File.dirname(__FILE__), '..')
    set :public, File.join(File.dirname(__FILE__), '..', 'public')
    set :views, File.join(File.dirname(__FILE__), '..', 'views')
    
    get '/' do
      haml :index
    end

    post '/' do
      haml :plot, :locals => { :query => params[:query] }
    end
    
    post '/search' do
      content_type :json
      { 
        :query => params[:query],
        :content => []
      }.to_json
    end
    
    get '/css/style.css' do
      content_type :css
      sass :style
    end 
  end
end