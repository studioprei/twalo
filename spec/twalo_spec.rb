require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Twalo" do
  context "GET /" do
    it "should respond ok" do
      get '/'
      last_response.should be_ok
    end
  end
end
