require File.join(File.dirname(__FILE__), "/../spec_helper" )

module Rumblr

  describe Client do

    it 'should not be able to be instantiated externally' do
      lambda { Client.new }.should raise_error(NoMethodError)
    end
    
    it 'should be able to instantiate itself' do
      lambda { Client.instance }.should_not raise_error
    end
  
  end
  
  describe Client, "authentication" do

    before(:each) { mock_successful(:authenticate) }
    
    it 'should raise an ArgumentError without email' do
      lambda do
        @client.authenticate('email', nil)
      end.should raise_error(ArgumentError)
    end

    it 'should raise an ArgumentError without password' do
      lambda do
        @client.authenticate(nil,'password')
      end.should raise_error(ArgumentError)
    end

    it 'should return a User if successful' do
      result = @client.authenticate('foo@foo.com','password')
      result.should be_an_instance_of(User)
    end
    
    it "should include user's existing tumblelogs" do
      user = @client.authenticate('foo@foo.com','password')
      user.tumblelogs.size.should == 2
    end
    
  end
  
  describe Client, "reading from a public tumblelog" do
    
    it 'without a URL should raise an error' do
      mock_successful(:anonymous_read)
      lambda do
        @client.read
      end.should raise_error(ArgumentError)
    end
    
    it 'with an empty URL should raise an error' do
      mock_successful(:anonymous_read)
      lambda do
        @client.read(:url => '')
      end.should raise_error(ArgumentError)
    end
    
    describe 'without credentials' do
      
      before(:each) do
        mock_successful(:anonymous_read)
        @tumblelog, posts = @client.read(:url => 'http://dummylog.tumblr.com/')
      end
      
      it 'should yield only posts' do
        @tumblelog.posts.all? {|post| post.kind_of?(Post)}.should be_true
      end
      
      it 'should not include all posts, assuming some are private' do
        @tumblelog.posts.size.should == 7
      end
      
      it 'should only include public posts' do
        @tumblelog.posts.all? {|post| post.public? }.should be_true
      end
      
      it 'should not include any private posts' do
        @tumblelog.posts.any? {|post| post.private? }.should be_false
      end
      
    end
    
    describe 'with valid credentials' do
      
      before(:each) do
        mock_successful(:authenticated_read)
        @tumblelog, posts = @client.read( :url => 'http://dummylog.tumblr.com/', 
                                          :email => 'valid',
                                          :password => 'valid' )
      end
      
      it 'should include all tumblelog posts' do
        @tumblelog.posts.size.should == 14
      end
      
      it 'should include all public posts' do
        @tumblelog.posts.find_all {|p| p.public? }.size.should == 7
      end
      
      it 'should include private posts' do
        @tumblelog.posts.find_all {|p| p.public? }.size.should == 7
      end
      
    end
    
  end
  
  describe Client, "writing to a public tumblelog" do
    
    before(:each) do
      mock_successful(:authenticated_read)
      @tumblelog, posts = @client.read( :url => 'http://dummylog.tumblr.com/', 
                                        :email => 'valid',
                                        :password => 'valid' )
      mock_successful(:authenticated_write)
    end
    
    it 'should raise an ArgumentError without post' do
      lambda do
        @client.write(nil, {:email => 'valid', :password => 'valid'})
      end.should raise_error(ArgumentError)
    end
    
    it 'should raise an ArgumentError if post is incorrect class' do
      lambda do
        @client.write("", {:email => 'valid', :password => 'valid'})
      end.should raise_error(ArgumentError)
    end
    
    it 'should raise an ArgumentError without creds' do
      lambda do
        @client.write(Rumblr::Post.new, nil)
      end.should raise_error(ArgumentError)
    end
    
    it 'should return an id' do
      @client.write(Rumblr::Post.new, {:email => 'valid', :password => 'valid'}).should == "10001"
    end
    
  end
  
end