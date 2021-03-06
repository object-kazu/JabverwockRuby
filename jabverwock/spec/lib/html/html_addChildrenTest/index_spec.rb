require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do

$PAGES =  %w(home about contact)

  
  

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.aList    
    arr = []
    $PAGES.each do |a|
      tdash = "www:" << a
      t = A.new.contentIs(a.capitalize).attr(:href, tdash)
      arr << t
    end
    arr
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs 'This is addChildren test'
    
    body.addChild heading
    body.addChildren aList
    
    body
  end
  
  html= HTML.new
  html.addChildren header, bodier
      
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
