require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  

  class << self
    
    
    def header
      head = HEAD.new
      title = TITLE.new
      title.content = "Hello world"
      head.addChild title
      
      head
    end

    
    def bodier
      body = BODY.new
      para = P.new.attr(:id__test).contentIs "yes"
      para.js.doc.byID.innerHTML("test done").rec
      
      body.addChild para
      
      body
    end

    
    
  end
  
  
  html = HTML.new
  
  html.addChild header
  html.addChild bodier

  # html.addMember header
  # html.addMember body
  
  
  $SA = "sample_Js_4"
  $PAGES =  %w(home)
  
  def self.testPATH
    current = ENV['PWD']
    switch = false
    if current.include?("BitTorrent")
      switch = true
    end
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{$SA}/"
  end
  
  
  $PAGES.each do |pp|
    if pp == "home"
      pp = "index"
    end
    n = pp + "Pressed" + ".html"
    html.pressConfig(name: n, dist: testPATH)
    html.pressInsert("a".varIs"#{pp}")

  end

end