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
  
  describe "tag parser" do
    before(:each) do
      @tag_parser = Twalo::TagParser.new
    end
    
    context "with single tweet" do
      before(:all) do
        @twitter_response = <<-TWITTER
          {
            "results": [{
              "profile_image_url": "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
              "created_at": "Mon, 09 Aug 2010 19:38:12 +0000",
              "from_user": "TwitterUser",
              "metadata": {
                  "result_type": "recent"
              },
              "to_user_id": null,
              "text": "A tweet with some tags #inception #graphic",
              "id": 1000000000,
              "from_user_id": 1000000000,
              "geo": null,
              "iso_language_code": "en",
              "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
            }]
          }
        TWITTER
      end
      
      it "should return all tags" do
        @tag_parser.parse(@twitter_response).should == ['inception', 'graphic']
      end      
    end
    
      context "with multiple tweets" do
        before(:all) do
          @twitter_response = <<-TWITTER
            {
              "results": [{
                "profile_image_url": "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
                "created_at": "Mon, 09 Aug 2010 19:38:12 +0000",
                "from_user": "TwitterUser",
                "metadata": {
                    "result_type": "recent"
                },
                "to_user_id": null,
                "text": "A tweet with some tags #inception #graphic",
                "id": 1000000000,
                "from_user_id": 1000000000,
                "geo": null,
                "iso_language_code": "en",
                "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
              },
              {
                "profile_image_url": "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
                "created_at": "Mon, 09 Aug 2010 19:38:12 +0000",
                "from_user": "TwitterUser",
                "metadata": {
                    "result_type": "recent"
                },
                "to_user_id": null,
                "text": "A tweet with some more tags #foo #bar",
                "id": 1000000000,
                "from_user_id": 1000000000,
                "geo": null,
                "iso_language_code": "en",
                "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
              }
              ]
            }
          TWITTER

        end

        it "should return all tags" do
          @tag_parser.parse(@twitter_response).should == ['inception', 'graphic', 'foo', 'bar']
        end
      end
      
      context "with duplicate tags" do
        before(:all) do
          @twitter_response = <<-TWITTER
            {
              "results": [{
                "profile_image_url": "http://a2.twimg.com/profile_images/000000000/p_normal.gif",
                "created_at": "Mon, 09 Aug 2010 19:38:12 +0000",
                "from_user": "TwitterUser",
                "metadata": {
                    "result_type": "recent"
                },
                "to_user_id": null,
                "text": "A tweet with some tags #foo #bar #foo",
                "id": 1000000000,
                "from_user_id": 1000000000,
                "geo": null,
                "iso_language_code": "en",
                "source": "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
              }]
            }
          TWITTER
        end
        
        it "should return each tag only once" do
          @tag_parser.parse(@twitter_response).should == ['foo', 'bar']
        end
      end

  end
end
