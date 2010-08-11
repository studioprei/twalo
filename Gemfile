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
  
  group :test_orm do
    gem 'dm-core'
    gem 'dm-sweatshop'
    gem 'dm-sqlite-adapter'
  end
  
  group :devtools do
    gem 'shotgun'
  end
end