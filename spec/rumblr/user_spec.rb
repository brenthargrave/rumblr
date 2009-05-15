require File.join(File.dirname(__FILE__), "/../spec_helper" )

module Rumblr

  describe User, 'initializing' do

    it 'should have the attributes of a User' do
      User.new.should respond_to( :email, 
                                  :password, 
                                  :can_upload_video, 
                                  :can_upload_aiff, 
                                  :vimeo_login_url,
                                  :can_upload_audio )
    end
    
    it 'tumblelogs should initialize empty' do
      User.new.tumblelogs.should be_a_kind_of(Array)
    end
    
  end
  
  describe User, 'logging in' do
    
    before(:each) do
      mock_successful(:authenticate)
    end
  
    it 'should login with email and password' do
      user = User.login(:email => 'valid_email', :password => 'valid_password')
      user.should be_an_instance_of(User)
    end
    
    it 'should not initialize without email' do
      lambda do
        User.login(:email => nil, :password => 'valid_password')
      end.should raise_error(ArgumentError)
    end
    
    it 'should not initialize without password' do
      lambda do
        User.login(:email => 'valid_email', :password => nil)
      end.should raise_error(ArgumentError)
    end
    
  end
  
  describe User, ', once logged in,' do
    
    before(:each) do
      mock_successful(:authenticate)
      @user = User.login(:email => 'valid_email', :password => 'valid_password')
    end
    
    it 'should provide one or more tumblelogs' do
      @user.tumblelogs.size.should == 2
    end
    
    it 'should provide *only* tumblelogs' do
      @user.tumblelogs.all? { |obj| obj.should be_an_instance_of(Tumblelog)  }
    end
    
    it 'should provide a primary tumblelog' do
      primary = @user.primary_tumblelog
      primary.is_primary.should == 'yes'
    end
    
  end
  
end
