require "lib/twalo"

Sinatra::Application.set :root, ::File.dirname(__FILE__)

run Twalo::App