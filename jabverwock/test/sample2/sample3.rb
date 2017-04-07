require "./path"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
 

  html= HTML.new

  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end

  def self.itemList (item)
    arr = []
    unless item.is_a? Array
      l = LI.new.contentIs item
      arr.append l
      return arr
    end
    
    if item.count > 0
      item.each do |i|
        l = LI.new.contentIs i     
        arr.append l 
      end
    end

    arr
  end
  
  def self.mList(title, *items)
    lm = LI_multi.new.contentIs title
    ul = UL.new
    l1 = itemList items
    ul.addChildren l1
    lm.addChild ul
    lm    
  end
  
  def self.orderList()
    o = OL.new
    ml = mList("Food", "a","b","c")
    mm = mList("Toy","1","2","3")
    o.addChildren [ml, mm]
    o
  end
  
  def self.bodier
    body = BODY.new
    ol = orderList
    body.addChild ol
    body
  end
  
  
  html.addChild header
  html.addChild bodier


  $SA = "sample2"

  
  def self.testPATH
    current = ENV['PWD']
    switch = false
    if current.include?("BitTorrent")
      switch = true
    end
    switch ? vPath1 = "/BitTorrent Sync" :  vPath1 = ""
    "/Users/shimizukazuyuki#{vPath1}/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/test/#{$SA}/"
  end
  

  n = $SA + "Pressed" + ".html"
  html.pressConfig(name: n, dist: testPATH)
  html.pressDefault
  

  
  
end
