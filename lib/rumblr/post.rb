module Rumblr

  # for attribute details, see Tumblr's documentation:
  # http://www.tumblr.com/api
  class Post < Resource

    TYPES = {
      'regular'      => "RegularPost",
      'photo'        => "PhotoPost",
      'quote'        => "QuotePost",
      'link'         => "LinkPost",
      'conversation' => "ConversationPost",
      'video'        => "VideoPost",
      'audio'        => "AudioPost"
    }

    attr_reader :id, :url, :type, :unix_timestamp, :date_gmt, :date, :tags, :private
    attr_accessor :tumblelog

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

    def attribute_hash
      {:date => date}
    end

  end

  class RegularPost < Post
    attr_accessor :title, :body

    def attribute_hash
      super.merge(:title => title, :body => body)
    end

  end

  class PhotoPost < Post
    attr_accessor :source, :data, :caption, :click_through_url

    def attribute_hash
      super.merge(:source => source, :data => data, :caption => caption, :click_through_url => click_through_url)
    end

  end

  class QuotePost < Post
    attr_accessor :quote, :source

    def attribute_hash
      super.merge(:quote => quote, :source => source)
    end

  end

  class LinkPost < Post
    attr_accessor :name, :url, :description

    def attribute_hash
      super.merge(:name => name, :url => url, :description => description)
    end

  end

  class ConversationPost < Post
    attr_accessor :title, :conversation

    def attribute_hash
      super.merge(:title => title, :conversation => conversation)
    end

  end

  class VideoPost < Post
    attr_accessor :embed, :data, :title, :caption

    def attribute_hash
      super.merge(:embed => embed, :data => data, :title => title, :caption => caption)
    end

  end

  class AudioPost < Post
    attr_accessor :data, :caption

    def attribute_hash
      super.merge(:data => data, :caption => caption)
    end

  end

end
