require File.join(File.dirname(__FILE__), "/../spec_helper" )

module Rumblr

  describe Tumblelog, 'instances' do
    
    it 'should have the attributes of a Tumblelog' do
      Tumblelog.new.should respond_to(  :name, :timezone, :cname, :title, :url, 
                                        :avatar_url, :is_primary, :type, :private_id)
    end
    
    it "' posts should initialize empty" do
      Tumblelog.new.posts.should be_a_kind_of(Array)
    end
    
  end
  
  describe Tumblelog, 'finder' do
    
    describe 'provided a valid URL' do
    
      it 'should successfully retrieve a tumblelog' do
        mock_successful(:anonymous_read)
        log = Tumblelog.find_by_url('valid_url')
        log.should be_an_instance_of(Tumblelog)
      end
      
      it 'should retrieve a tumblelog with posts' do
        mock_successful(:anonymous_read)
        log = Tumblelog.find_by_url('valid_url')
        log.posts.first.should be_a_kind_of(Post)
        log.posts.first.type.should_not be_nil
      end
      
    end
    
  end
  
end
