require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Twalo" do
  context "Sanity" do
    it "should respond ok" do
      get '/'
      last_response.should be_ok
    end
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
  
  describe "hashtag json search service" do
    context "with valid query" do
      before(:all) do
        post '/search', { :query => "inception"}
      end

      it "should respond ok" do
        last_response.should be_ok
      end

      it "should respond with json" do
        last_response.content_type.should == 'application/json'
      end

      it "should respond with valid json" do
        lambda { JSON.parse(last_response.body) }.should_not raise_error(JSON::ParserError)
      end
      
      describe "response json" do
        before(:each) do
          @json = JSON.parse(last_response.body)
        end
        
        it "should store the query under to the query key" do
          @json['query'].should == 'inception'
        end
        
        it "should store an array under the content key" do
          @json['content'].should be_a_kind_of(Array)
        end
      end
    end
  end
end
