
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    class << self
      def bodier
        body = BODY.new
        div = DIV.new.attr(:id__div1)
        
        p1 = P.new.attr(:id__p1).contentIs "This is a paragraph."
        p2 = P.new.attr(:id__p2).contentIs "This is another paragraph."


        # bad order
        # div.jdoc.byID.is_var :parent
        # p1.jdoc.byID.is_var :child
        # div.jdoc.removeChild :parent, :child
        
        #good order
        div.jdoc.byID.is_var :parent
        p1.jdoc.byID.is_var :child
        p1.jdoc.removeChild :parent, :child

        
        div.addChildren p1, p2
        body.addChild div
        body
      end
    end
    
    html = HTML.new
    html.addChild bodier
    
    doc = DOCTYPE.new
    doc.addMember html
    
    doc.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
