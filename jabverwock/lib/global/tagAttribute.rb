if $FOR_GEM
  
  require "global/globalDef"
  require "global/tagAttributeTempelete"
  
else
  
  require_relative "globalDef"
  require_relative "tagAttributeTempelete"

end




module Jabverwock
  using StringExtension
  
  class TagAttribute < TagAttributeTemplete
    
    # caution! do not use "_", because symbole like ":id_test" may splite as "id" and "test"
    list  = [:id,:cls,:href,:lang, :target, :type, :rel]
    list += [:name, :http_equiv,:content,:charset,:scheme]
    list += [:accesskey,:contenteditable,:dir, :hidden, :spellcheck, :style, :tabindex,:title,:translate]
    list += [:rowspan, :colspan, :border, :cellpadding, :cellspacing]
    list += [:src, :alt, :width, :height]
    self.define_attributes list
       
    def initialize
      super
    end

   
  end

  # p a = TagAttribute.new
  # a.id = "test"
  # a.src = "/usr/local/"
  # p a
  
end

