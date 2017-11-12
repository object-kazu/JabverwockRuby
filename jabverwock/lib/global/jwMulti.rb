require "global/globalDef"
require "global/jw_CSS_OPAL_JS"
require "global/jw"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class express multi line html tag, like head, body etc.
  class JWMulti < JW_CSS_OPAL_JS
    attr_accessor :childStringArray
    
    def initialize
      super
      @childStringArray = []
      @css = CSS.new("#{@name}")
    end

    def addChild(child)
      unless child.is_a? JW
        p "child is >> #{child.class} error: child should be JW, JW_CSS_JS or JW_CSS class "
        assert_raise{}
      end
      
      # js
      addJS child

      # css
      addChildCSS child
                 
      # html
      addChildHTML child
            
    end

    def addChildCSS(child)
      if child.cssArray.count > 0
        @cssArray += child.cssArray
      end

      if child.css ||= CSS.new("#{@name}")
        # child.updateCssName
        @cssArray << child.css
      end
    end

    def addChildHTML(child)
      child.assembleHTML
      addChildString(child.templeteString)      
    end
    
    
    def addChildren(*children)
      children.flatten.each do |c| 
        addChild c
      end
    end
    
    def contentIs (str)
      addChildString str
      self
    end
    
    def addChildString(childString)
      KString.isString? childString      
      @childStringArray << childString
    end
      
    def addChildStrings(*children)
      children.each do |c|
        addChildString c
      end
    end
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      
      childAssemble
      
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)

    end

    def childAssemble
      @childStringArray.each do |a|
        @templeteString << a << $RET       
      end
    end
    
  end

  multiList = KSUtil.multiTags
  
  multiList.each do |list|
    Object.const_set list, Class.new(JWMulti){    
    }
  end


  #  a = JWMulti.new
  # p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
  
end
