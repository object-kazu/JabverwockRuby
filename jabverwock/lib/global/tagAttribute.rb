require_relative "globalDef"
require_relative "tagAttributeTempelete"

module Jabverwock
  using StringExtension
  
  class TagAttribute < TagAttributeTemplete

    list = [:id,:cls,:href,:lang, :target]
    
    self.define_attributes list
       
    def initialize
      super
    end

   
  end

  # p a = TagAttribute.new
  # a.id = "test"

end

