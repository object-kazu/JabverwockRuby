require "global/globalDef"

require "global/jw"
require "global/jw_CSS"
require "global/jw_CSS_JS"
require "global/jw_CSS_OPAL_JS"
require "global/jwOrigin"

require "js/jsObject"
require "opal/opalFileReader"
require "css/css"

module Jabverwock
  
  class JWS < JW_CSS_OPAL_JS
    
    def initialize
      super
      # @parent = []
    end
    
    # class method
    # PREFIX_INDEX = "index"
    
    class << self
            
      # def transrate(jwKls)
      #   ans = ""
      #   if jwKls.is_a? JW
      #     ans = jwKls.tgStr
      #   else
      #     ans = jwKls.chomp
      #   end
      #   ans
      # end
      # def transrate_css(jwKls)
      #   ans = ""
      #   if jwKls.is_a? JW
      #     ans = jwKls.cssString
      #   else
      #     ans = jwKls.chomp
      #   end
      #   ans
      # end

      # def makeStringFrom(arr)
      #   arr.inject(""){ |res,a| res << a + "\n" }
      # end
      
      # # @param [Array] arg  like [a,b,[c,d],e]
      # # []: express child
      # # @return [String] tgStr
      # def buildToString(arr)
      #   members = []
        
      #   arr.each{ |a|
      #     if a.is_a? Array
      #       child = buildToString a
      #       membersLast = addChild members.pop, child
      #       members << membersLast
      #     else
      #       members << transrate(a)
      #     end
      #   }
      #   makeStringFrom members
      # end

      # def build(arr)
      #   ans = buildToString arr        
      #   v = JW_CSS_OPAL_JS.new
      #   v.name = "builder" # make builder tag, this tag is remove at press class, function core.
      #   v.templeteString = ans
      #   v
      # end
      
      # def addChild(parentString,childString)
      #   #parentStringの中にchildStringを入れる
      #   parentString.gsub(/>\n.*<\//, ">\n#{childString}<\/")
      # end

      # [a,[b]] => a.addChild b
      # [a,b] => a.addMember b
      ################ test code ###########
      def build(arr)
        f = arr.first
        members = []
        arr.each{ |s|
          if s.is_a? Array # child
            makeChild members.last, s
          else # member
            members << s      
          end
        }
        ans = makeMember(members)

        
        v = JW_CSS_OPAL_JS.new
        v.name = "builder" # make builder tag, this tag is remove at press class, function core.
        v.templeteString = ans
        v
      end


      def makeChild(parent, arr)
        #arr[0].addChild arr[1]...
        last = parent #inital parent
        
        arr.each{ |s|
          if s.is_a? Array
            makeChild parent, s
          else
            last.addChild s
            last = s
          end
        }
      end
      def makeMember(arr)
        #arr[0].addMemver arr[1]...
        f = arr.shift
        arr.each{ |s|
          f.addMember s
        }
        f.tgStr
      end

      ################ ###################
      
      
    end

  end
  
  all = KSUtil.allTags
  all.each do |tag|
    if KSUtil.singleTags.include? tag
      Object.const_set tag, Class.new(JWSingle){
      }
    end
    
    if KSUtil.multiTags.include? tag
      Object.const_set tag, Class.new(JWMulti){
      }
    end

    if KSUtil.oneTags.include? tag
      Object.const_set tag, Class.new(JWOneTag){
      }
    end

    if KSUtil.headingList.include? tag
      Object.const_set tag, Class.new(HEADING){
      }      
    end
    
    if KSUtil.tableTags.include? tag
      obj = ""
      case tag
      when "TABLE"
        obj = JWTable
      when "TROW"
        obj = TableRow
      when "THEAD"
        obj = TableHeader
      when "TDATA"
        obj = TableData
      end
      Object.const_set tag, Class.new(obj){
      }
    end    
  end
end
