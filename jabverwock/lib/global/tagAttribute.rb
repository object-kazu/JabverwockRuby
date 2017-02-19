require "global/globalDef"
require "global/tagAttributeTempelete"

#require_relative "globalDef"
#require_relative "tagAttributeTempelete"

module Jabverwock
  using StringExtension
  
  class TagAttribute < TagAttributeTemplete

    list = [:id,:cls,:href,:lang, :target]
    list += [:name, :http_equiv,:content,:charset,:scheme]
    list += [:accesskey,:contenteditable,:dir, :hidden, :spellcheck, :style, :tabindex,:title,:translate]
    list += [:row_span, :col_span]
    self.define_attributes list
       
    def initialize
      super
    end

   
  end

  # p a = TagAttribute.new
  # a.id = "test"

end

