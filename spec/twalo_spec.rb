require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Twalo" do
  context "GET /" do
    it "should respond ok" do
      get '/'
      last_response.should be_ok
    end
    
    describe "search for hashtag" do
      before(:each) do
        visit '/'
        fill_in "Search", :with => "inception"
        click_button "Plot"
      end
      
      it "should show search query" do
        response_body.should contain "Plotting inception"
      end
    end
  end
end
