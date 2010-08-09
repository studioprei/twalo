$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'spec'
require 'spec/autorun'
require "rack/test"
require 'webrat'

require 'twalo'

Webrat.configure do |config|
  config.mode = :rack
end

module TwaloHelper
  def app
    Twalo::App
  end
end

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.include TwaloHelper
end
