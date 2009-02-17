module Rumblr
  
  class Client
    include Singleton
    
    # The default set of headers for each request.
    DEFAULT_HEADER = {
        'User-Agent'  => 'Rumblr',
        'Accept'      => 'application/xml'
    }
    
    def authenticate(email,password)
      raise ArgumentError unless (email && password)
      user_credentials = { :email => email, :password => password }
      uri = URI::HTTP.build({:path => '/api/authenticate'})
      request = Net::HTTP::Post.new(uri.request_uri, DEFAULT_HEADER)
      request.set_form_data(user_credentials)
      
      user_attributes = nil
      complete_request(request) do |response_body|
        user_attributes = parse_user_attributes_from(response_body)
        user_attributes.merge!(user_credentials)
      end
      User.new(user_attributes)
    end
    
    def read(options={})
      tumblelog, posts = nil, [] # initialize the return targets
      
      uri = URI::HTTP.build({:path => '/api/read'})
      request = Net::HTTP::Post.new(uri.request_uri, DEFAULT_HEADER)
      request.set_form_data(options)
      
      raise(ArgumentError) unless (options && options[:url] && !options[:url].empty?)
      
      request_url_host = URI.parse(options[:url]).host
      complete_request(request,host=request_url_host) do |response_body|
        parser, parser.string = XML::Parser.new, response_body
        doc = parser.parse
        # parse and map posts
        posts = doc.find('//tumblr/posts/post').inject([]) do |array, element|
          post_attrs = cleanup_hash(element.attributes.to_h)
          # inner elements =>  sublcass-specific attribute hash
          subclass_attrs = element.children.inject({'tags' => []}) do |hash, child|
            hash['tags'] << child.content if (child.name[/tag/])
            hash[child.name] = child.content
            hash
          end
          # merge hashes, clean out cruft
          inner_attrs = cleanup_hash(subclass_attrs)
          inner_attrs.delete(:text)
          inner_attrs.delete(:tag)
          post_attrs.merge!(inner_attrs)
          # turn attributes into proper model
          klass = case post_attrs[:type]
                  when 'regular'      then RegularPost
                  when 'photo'        then PhotoPost
                  when 'quote'        then QuotePost
                  when 'link'         then LinkPost
                  when 'conversation' then ConversationPost
                  when 'video'        then VideoPost
                  when 'audio'        then AudioPost
                  else raise          'unknown post type'
                  end
          post = klass.new(post_attrs)
          array << post
          array
        end
        # parse and map tumblelog
        tumblelog_element = doc.find_first('//tumblr/tumblelog')
        tumblelog_attrs = cleanup_hash(tumblelog_element.attributes.to_h)
        tumblelog_attrs.merge!(:url => options[:url])
        tumblelog = Tumblelog.new(tumblelog_attrs)
      end
      return tumblelog, posts
    end
    
    
    protected
    
    # Starts and completes the given request. Returns or yields the response body.
    def complete_request(request, host = URI.parse(Rumblr.api_url).host)
      http = Net::HTTP.new(host)
      # Set to debug http output.
      # http.set_debug_output $stderr
      response = http.start { |http| http.request(request) }
      
      case response
      when Net::HTTPSuccess           then  yield response.body if block_given?
      when Net::HTTPBadRequest        then  raise Rumblr::RequestError, parse_error_message(response)
      when Net::HTTPForbidden         then  raise Rumblr::AuthorizationError, parse_error_message(response)
      when Net::HTTPNotFound          then  raise Rumblr::MissingResourceError, parse_error_message(response)
      when Net::HTTPMovedPermanently  then  raise Rumblr::MovedResourceError, parse_error_message(response)
      when Net::HTTPServerError       then  raise Rumblr::ServerError, connection_error_message
      else                                  raise "Received an unexpected HTTP response: #{response}"
      end
      
      response.body
    end
    
    # Extracts the error message from the response for the exception.
    def parse_error_message(response)
      response.body
    end
    
    def connection_error_message
      "There was a problem connecting to Tumblr"
    end
    
    
    private
    
    def parse_user_attributes_from(response_body)
      parser, parser.string = XML::Parser.new, response_body
      doc = parser.parse
      tumblelogs = doc.find('//tumblr/tumblelog').inject([]) do |array, element|
        tumblelog_attrs = cleanup_hash(element.attributes.to_h)
        array << Tumblelog.new(tumblelog_attrs)
        array
      end
      raw_user_attributes = doc.find('//tumblr/user').first.attributes.to_h
      user_attributes = cleanup_hash(raw_user_attributes)
      user_attributes.merge!(:tumblelogs => tumblelogs)
    end
    
    def cleanup_hash(attrs={})
      clean_attrs = attrs.inject({}) do |hash,(key,value)|
        mapped_key = key.gsub(/-/,'_').to_sym
        mapped_value =  case value
                        when /($1^|$yes^)/ then true
                        when /($0^|$no^)/ then false
                        else value
                        end
        hash[mapped_key] = mapped_value
        hash
      end
    end
  
  end

end