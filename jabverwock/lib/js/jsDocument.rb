
if $FOR_GEM
  
  require "global/globalDef"
  require "js/jsBase"
  require "js/jsVar"
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  require_relative "./jsVar"
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  
  #This class express JS Document class
  class JsDocument < JsBase
    attr_accessor :result, :query
    
    def initialize(*inits)
      super inits
      @obj = "document"
      @query = ""
      @element = Element.new(self)
    end

    ### delegate  ###
    def rec
      recBy @element.ec
    end

    def recBy (str)
      @orders << str
    end    

    def recs
      recsBy @element.ecs
    end

    def recsBy (str)
      str.each{ |s| recBy s }
    end
    
    def selectElement(slect,obj)
      updateSelectors
      cp =  @obj.dot(slect).inParenth(obj) + $JS_CMD_END
      @element.content = cp
      @element
    end

    def modifyElement(order, elem)
      updateSelectors
      cp =  @obj.dot(order).inParenth(elem) + $JS_CMD_END
      @element.content = cp
      @element
    end

    def treatElement (order,elem)
      updateSelectors
      cp = @obj.dot(order) + "(" + "#{elem}" + ")"  + $JS_CMD_END
      @element.content = cp
      @element
    end

    ### add and delete element ###
    def createElement(ele)
      modifyElement("createElement",ele)
    end

    def removeChild(child)
      treatElement("removeChild",child)
    end

    def appendChild(child)
      treatElement("appendChild",child)
    end

    def replaceChild(child)
      treatElement("replaceChild",child)
    end

    
    # write function include rec, so do not allow to chain other method
    # like: createElement.innerHTML....
    def write(str)
      modifyElement("write", str).rec
    end    
    


    ### find element ###
    def byID
      selectElement("getElementById", @id)
    end
    
    def byClassName
      updateSelectors
      selectElement("getElementByClassName",@cls)
    end

    def byTagName
      updateSelectors
      selectElement("getElementByTagName", @name)
    end

    def querySelectorAll
      updateSelectors
      selectElement("querySelectorAll",@query)
    end
    
    def querySelectorAllBy(que)
      updateSelectors
      @query = que
      querySelectorAll
    end

    ### evant handler ###
    #    document.getElementById(id).onclick = function(){code}
    # def onclick (code)
    #   #under constuct
    #   p "#{code}"
    # end

    ### Finding HTML Objects ###
    # document.anchors	Returns all <a> elements that have a name attribute	1
    # document.applets	Returns all <applet> elements (Deprecated in HTML5)	1
    # document.baseURI	Returns the absolute base URI of the document	3
    # document.body	Returns the <body> element	1
    # document.cookie	Returns the document's cookie	1
    # document.doctype	Returns the document's doctype	3
    # document.documentElement	Returns the <html> element	3
    # document.documentMode	Returns the mode used by the browser	3
    # document.documentURI	Returns the URI of the document	3
    # document.domain	Returns the domain name of the document server	1
    # document.domConfig	Obsolete. Returns the DOM configuration	3
    # document.embeds	Returns all <embed> elements	3
    # document.forms	Returns all <form> elements	1
    # document.head	Returns the <head> element	3
    # document.images	Returns all <img> elements	1
    # document.implementation	Returns the DOM implementation	3
    # document.inputEncoding	Returns the document's encoding (character set)	3
    # document.lastModified	Returns the date and time the document was updated	3
    # document.links	Returns all <area> and <a> elements that have a href attribute	1
    # document.readyState	Returns the (loading) status of the document	3
    # document.referrer	Returns the URI of the referrer (the linking document)	1
    # document.scripts	Returns all <script> elements	3
    # document.strictErrorChecking	Returns if error checking is enforced	3
    # document.title	Returns the <title> element	1
    # document.URL	Returns the complete URL of the document


    private
    def updateSelectors
      updateSelector(@id,@cls,@name)      
    end
    
  end

  
  # This class express element
  class Element
    
    # contentを受け取ってecを返す
   attr_writer :content
   attr_reader :ec, :ecs
   
    def initialize(delegate)
      @delegate = delegate
      @content = ""
      @ec = ""

      @ecs = []
    end

    def element
      @content
    end

    def record
      @delegate.orders.first
    end

    def records
      @delegate.orders
    end

    def inVar(name)
      v = JsVar.new
      @ecs << v.is( name, self.record).record
      rec
      # if inVar was call, self.record[0] was use at jsVar. For example,
      # self.record[0] = "document.getElementById('');"
      # then,inVar(:test) call and use self.record[0] value and make new sentence, like
      # self.record[1] = "var test = document.getElementById('');"
      # so self.record[0] is no needs after inVar call that remove self.record[0]
      self.records.shift
      self
    end
    
    def export
      @ec
    end
    
    def rec
      if @ecs.count > 0
        recs
        return
      end
      
      @ec = @content if @ec == ""
      @delegate.recBy @ec
      @ec = ""

    end
    
    def index(i)
      s = KString.remove_Js_Cmd_End @content
      @ec = s + "[#{i}];"
      @content = @ec
      self
    end
    
    ### each element ###

    def attribute(str)
      elementChanging_Equal("attribute",str)
      rec
    end

    # arg ex) :click_ or :click_2 and so on == :click
    # because addEventListener allow use same event(such as click),
    # but ruby hash do not allow same key
    # see jsDocumentTest.rb
    def addEventListener(**event_function_hash)
      addEventListenerBase false, event_function_hash
      rec
    end
    
    def addEventListenerUseCapture(**event_function_hash)
      addEventListenerBase true, event_function_hash
      rec
    end

        
    def innerHTML(str)
      elementChanging_Equal("innerHTML",str)
      rec
    end


    def setAttribute(**attrStr)
      attrStr.each do |att, str|
        sKey = spliteSympbolByUnderBar att 
        e = "".inDoubleQuot(sKey) + $COMMA.inDoubleQuot(str)
        @ecs << contentRemoveJSEnd.dot("setAttribute") + "(" + e + ")" + $JS_CMD_END
      end
      rec
    end
    
    def style (**property_val)
      property_val.each do |property, val|
        @ecs << contentRemoveJSEnd.dot("style").dot(property.to_s) +  $EQUAL.inSingleQuo(val) + $JS_CMD_END
      end
      rec
    end

    ### node ###
    def node(kind,*type)
      
      k = kind.to_s
      t = type.empty? ? "" : type.first.to_s
      
      ans = contentRemoveJSEnd.dot(k)
      ans << "".dot(typeName(t)) unless t.empty?
      @ecs << ans + $JS_CMD_END
      rec
      self
    end

    def parentNode(*type)
      node :parentNode, *type
    end
    
    def childNodes(position, *type)
      node "childNodes[#{position}]",*type
    end

    def nextSibling
      node :nextSibling,  ""
    end

    def previousSibling
      node :previousSibling,  ""
    end
    
    
    def firstChild(*type)
      node :firstChild, *type
    end

    def lastChild(*type)
      node :lastChild, *type
    end


    ### private methods ###

    private
    def recs
      @delegate.recsBy @ecs
      @ecs = []      
    end
    
    def src (str)
      elementChanging_Equal("src",str)
    end

    def spliteSympbolByUnderBar(sym)
      sym.to_s.split("_").first
    end

    def contentRemoveJSEnd
      KString.remove_Js_Cmd_End @content
    end
    
    def addEventListenerBase(ucp, event_function_hash)
      event_function_hash.each do |event, func| 
        rKey = spliteSympbolByUnderBar event
        @ecs << addEventListenerMain(contentRemoveJSEnd, rKey, func, ucp) 
      end
    end
    
    def addEventListenerMain(content, event, func, useCaption = false)
      ucp = useCaption ? ",true": ""
      content.dot("addEventListener") + "(".inDoubleQuot(event) + $COMMA.inSingleQuo(func) + ucp + ")" + $JS_CMD_END
    end
    
    ### change element ###
    def elementChanging_Equal (act,str)
      s = KString.remove_Js_Cmd_End @content
      @ec = contentRemoveJSEnd.dot(act) + $EQUAL.inDoubleQuot(str) + $JS_CMD_END
      self
    end
    
    def elementChanging (act,str)
      @ec = contentRemoveJSEnd.dot(act) + "(" + str + ")" + $JS_CMD_END
      self
    end

    def typeName(t)
      v = "node"
      tArr = %w(Value Type Name)
      tArr.each do |a|
        if a.downcase == t.to_s
          return v << a
        end
      end
    end

    
  end


  # p a = JsDocument.new("","","")
  # p a.byID
  # p a.write("adas")

  
  # a = Element.new
  # a.content = "aaaa;"
  # a.innerHTML "bbbb"
  
end
