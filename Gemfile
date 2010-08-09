source :gemcutter

gem 'sinatra'
gem 'haml'
gem 'json'
gem 'rest-client'

if ENV['RACK_ENV'] != 'prouction'
  group :test do
    gem 'rspec'
    gem 'rack-test'
    gem 'webrat'
  end
  
  group :devtools do
    gem 'shotgun'
  end
end