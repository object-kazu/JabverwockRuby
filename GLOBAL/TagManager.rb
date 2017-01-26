class TagManager
  attr_accessor :name, :id, :cls
    
#   // tag attribute
#    var attr: TagAttribute = TagAttribute()
    
    
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
    
  end

  def addName
    if !@name.empty?
      st = "name=" + "\"" + @name + "\""
      addSpace
      @tempOpenString += st
    end
  end

  def addID
    if !@id.empty?
      st = "id=" + "\"" + @id + "\""
      addSpace      
      @tempOpenString  += st
    end
  end

  def addCls
    if !@cls.empty?
      st = "class=" + "\"" + @cls + "\""
      addSpace
      @tempOpenString  += st        
    end
  end

  def addSpace
    if !@tempOpenString.empty?
       @tempOpenString += SPC
    end
  end
  
  def openString
    addName
    addID
    addCls
    
    
    @tempOpenString
  end

  def closeString
    
    @tempCloseString
  end
  
end
