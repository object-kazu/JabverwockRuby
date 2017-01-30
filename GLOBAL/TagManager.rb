require_relative "globalDef" 
require_relative "tagAttribute" 

module Jabverwock
  class TagManager
    attr_accessor :name, :id, :cls, :tagAttribute, :isSingleTag
    
    
    
    # //script tag
    # var jsPath    : String    = ""
    # var jsPathPlusName :String   = ""
    # var jsFileName: String    = ""
    # var jsType    : String    = ""
    
    
    def initialize
      @tempOpenString = String.new
      @tempCloseString = String.new
      
      @name = String.new
      @id   = String.new
      @cls  = String.new
      
      @tagAttribute = TagAttribute.new
      @attributeString = String.new

      @isSingleTag = false
    end

    def addID
      if !@id.empty?
        @id = KS.checkString(@id)
        st = "id=" + "\"" + @id + "\""
        @id = addSpace(st)
      end
    end

    def addCls
      if !@cls.empty?
        @cls = KS.checkString(@cls)
        st = "class=" + "\"" + @cls + "\""
        @cls = addSpace(st)
      end
    end

    def addAttribute
      if !@tagAttribute.aString.empty?
        @attributeString = KS.checkString(@attributeString)
        @attributeString = addSpace(@tagAttribute.aString)
      end
    end

    def addSpace(str)
      if !str.empty?
        str = KS.checkString(str)
        str = $SPC + str
      end
      str
    end

    def isBrTag
      @name == "br" ? true : false
    end
    
    def openString
      addID
      addCls
      

      if isBrTag()
        return ""
      end

      # tag attribute treatment
      addAttribute
      
      @tempOpenString = "<" + @name + @id + @cls + @attributeString + ">"
    end

    def closeString
      if isBrTag
        return @tempCloseString = "<" + @name  + ">"
      end
      
      @tempCloseString = "</" + @name  + ">"
    end
    
  end
end

__END__

