module Rumblr

  class User < Resource
    attr_reader :email, :password, :can_upload_video, :can_upload_aiff, :vimeo_login_url, :can_upload_audio

    def tumblelogs
      instance_variable_get(:@tumblelogs) || []
    end

    def primary_tumblelog
      self.tumblelogs.find { |log| log.primary? }
    end

    class << self
      def login(attrs={})
        email, password = attrs[:email], attrs[:password]
        Client.instance.authenticate(email,password)
      end
    end

  end

end
