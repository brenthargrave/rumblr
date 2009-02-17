module Rumblr

  class MissingResourceError < Exception; end
  class MovedResourceError < Exception; end
  class AuthorizationError < Exception; end
  class RequestError < Exception; end
  class ServerError < Exception; end
  
  class << self
    attr_accessor :api_url
  end
end

Rumblr.api_url = "http://www.tumblr.com"

require 'rubygems'
require 'singleton'
require 'net/http'
require 'uri'
gem 'libxml-ruby', '>= 0.8.3'
require 'xml'
require 'pp'

require 'rumblr/client'
require 'rumblr/resource'
require 'rumblr/tumblelog'
require 'rumblr/user'
require 'rumblr/post'