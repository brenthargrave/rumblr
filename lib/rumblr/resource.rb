module Rumblr
  
  class Resource
    
    def initialize(attrs={})
      attrs.each do |key,value|
        self.instance_variable_set(:"@#{key.to_s}", value)
      end
    end
  
  end
  
end