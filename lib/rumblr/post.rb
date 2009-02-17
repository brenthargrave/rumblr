module Rumblr
  
  # for attribute details, see Tumblr's documentation:
  # http://www.tumblr.com/api
  class Post < Resource
    attr_reader :id, :url, :type, :unix_timestamp, :date_gmt, :date, :tags, :private
    
    def initialize(attrs={})
      @private = false
      super
    end
    
    def private?
      @private
    end
    
    def public?
      !self.private?
    end
    
  end
  
  class RegularPost < Post
    attr_reader :title, :body
  end
  
  class PhotoPost < Post
    attr_reader :source, :data, :caption, :click_through_url
  end
  
  class QuotePost < Post
    attr_reader :quote, :source
  end
  
  class LinkPost < Post
    attr_reader :name, :url, :description
  end
  
  class ConversationPost < Post
    attr_reader :title, :conversation
  end
  
  class VideoPost < Post
    attr_reader :embed, :data, :title, :caption
  end
  
  class AudioPost < Post
    attr_reader :data, :caption
  end
  
end