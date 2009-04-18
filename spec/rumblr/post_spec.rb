require File.join(File.dirname(__FILE__), "/../spec_helper" )

module Rumblr
  
  describe Post, 'instances' do
    
    it 'should have attributes shared by every Post' do
      Post.new.should respond_to(:id, :url, :type, :unix_timestamp, :date_gmt, :date, :tags, :private)
    end
    
    it 'private attribute should default to false' do
      Post.new.private.should be_false
    end
    
    it 'should provide it private status' do
      Post.new.should respond_to(:private?)
    end
    
    it 'should provide it public status (inverse of private status)' do
      Post.new.should respond_to(:public?)
    end
    
    it 'should provide a hash of attributes and values for API' do
      Post.new.should respond_to(:attribute_hash)
    end
    
  end
  
end
