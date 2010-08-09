require "sinatra/base"
require "haml"
require "sass"

module Twalo
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
    
    get '/css/style.css' do
      content_type :css
      sass :style
    end
    
  end
end