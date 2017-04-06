if $FOR_GEM
  
  require "global/globalDef"
  require "global/jw_CSS_JS"
  require "global/jw"

  require "css/css"
    
else
  #gem uninstall version
  require "../../lib/global/globalDef"
  require "../../lib/global/jw_CSS_JS"
  require "../../lib/global/jw"
  require "../../lib/css/css"
  
end

module Jabverwock
  using StringExtension
  
  class JWMulti < JW_CSS_JS
    attr_accessor :childStringArray
    
    
    def initialize
      super
      @childStringArray = []
      
    end

    def addChild(child)
      unless child.is_a? JW
        p "child is >> #{child.class}" 
        p "error: child should be JW, JW_CSS_JS or JW_CSS class "
        assert_raise{}
      end
      
      # js
      addJS child

      # css
      if child.cssArray.count > 0
        @cssArray += child.cssArray
      end

      if child.css != nil
        @cssArray << child.css
      end
            
      
      # html
      child.assembleHTML
      addChildString(child.templeteString)

            
    end

    def addChildren(children)
      children.each do |c| 
        addChild c
      end
    end
    
    def contentIs (str)
      addChildString str
      self
    end
    
    def addChildString(childString)
      # if childString == nil
      #   p "childString is nill"
      #   return
      # end      
      KString.isString? childString      
      @childStringArray << childString
    end
      
    def addChildStrings(children)
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
      tem = []
      @childStringArray.each do |t|
        tem << KString.addTab(t)
      end
      tem.each do |a|
        @templeteString += a + $RET
      end
    end
    
  end

  multiList = ["BLOCKQUOTE","BODY","DIV","FOOTER","FORM","HTML","HEAD","PRE","SCRIPT",
               "STYLE", "SELECT"]

  multiList += ["OL", "UL", "LI_multi"]
  
  multiList.each do |list|
    Object.const_set list, Class.new(JWMulti){
    
      attr_accessor :name
      
      def initialize
        super
        @name = self.class.name.downcase

        if @name == "li_multi"
          @name = "li"
        end
        
        @css = CSS.new("#{@name}")
  
      end
    }
  end


  # a = JW_CSS_JS.new
  # p a
  
end
