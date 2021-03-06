require 'test/unit' 
require '../../lib/tabbing/tabbing'

module Jabverwock

  class TabbingTest < Test::Unit::TestCase
    class << self
      
      
      # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
      def startup
        p :_startup
      end

      # テスト群の実行後に呼ばれる
      def shutdown
        p :_shutdown
      end
    end

    # 毎回テスト実行前に呼ばれる
    def setup
      p :setup
      @tb = Tabbing.new
    end

    # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
    def cleanup
      p :cleanup
    end

    # 毎回テスト実行後に呼ばれる
    def teardown
      p :treadown
    end

    ############## test ###############


    # test "read txt" do
    #   t = Tabbing.new

    #   t.fileReading 'sample.txt'
    #   p t.elmArray
    # end
    
    # test "STYLE_TAG_EXTRACTED" do
    #   p Tabbing::STYLE_TAG_EXTRACTED
    # end


    # test "main test" do
    #   t = Tabbing.new
    #   t.fileReading 'sample.txt'
    #   # p t.tabbedTxt
      
    #   assert_equal t.tabbedTxt,"<html>\n\t<head>\n\t\t<title>This is my first page</title>\n\t</head>\n\t<body>\n\t\t<h1 id=\"example1\">this text is red</h1>\n\t\t<p >Hello world! sample</p>\n\t\t<input type=checkbox name=\"shumi\" value=\"PC\">パソコン\n\t</body>\n</html>\n"      
    # end
    
    # test "main test case 2" do
    #   t = Tabbing.new
    #   t.fileReading 'sample2.txt'
    #   p t.tabbedTxt
      
    # end
    
    # test "extractStyle" do
    #   l = "tstttt\n<style>\nkokoko\n</style>\ntestetetttt"
    #   @tb.readLine l
    #   ans = @tb.extractStyle
    #   assert_equal ans, ["<style>\n", "kokoko\n", "<\/style>\n"]
    # end

    # test "cssTabbing case 1" do
    #   l = "tstttt\n<style>\nkokoko\n</style>\ntestetetttt"
    #   @tb.readLine l
    #   ans = @tb.cssTabbing
    #   assert_equal ans, ["<style>\n", "\tkokoko\n", "<\/style>\n"]
    # end

    
    # test "cssTabbing case 2" do
    #   l = "tstttt\n<style>\np{\ncolor:red;\n}\n</style>\ntestetetttt"
    #   @tb.readLine l
    #   ans = @tb.cssTabbing
    #   assert_equal ans, ["<style>\n", "\tp{\n", "\t\tcolor:red;\n", "\t}\n", "<\/style>\n"]

    # end
    
    # test "cssTabbing case false, no style" do
    #   l = "tstttt\np{\ncolor:red;\n}\nntestetetttt"
    #   @tb.readLine l
    #   ans = @tb.cssTabbing
    #   assert_equal ans, ""

    # end    
    
    # test "extract Script" do
    #   l = "kokoko\n<script>\ndoc.write\n</script>\nerqeqreq"
    #   @tb.readLine l
    #   ans = @tb.extractScript
    #   assert_equal ans, ["<script>\n", "doc.write\n", "</script>\n"]
    # end
    
    # test "jsTabbing case 1" do
    #   l = "kokoko\n<script>\ndoc.write\n</script>\nerqeqreq"
    #   @tb.readLine l
    #   ans = @tb.jsTabbing
    #   assert_equal ans, ["<script>\n", "\tdoc.write\n", "</script>\n"]
    # end
    
    # test "jsTabbing case false" do
    #   l = "kokoko\ndoc.write\nerqeqreq"
    #   @tb.readLine l
    #   ans = @tb.jsTabbing
    #   assert_equal ans, ""
    # end
    
    # test "main loop " do
    #   l = "<html>\n<head>\n<p></p>\n</head>\n</html>"
    #   t = Tabbing.new
    #   t.readLine l
    #   assert_equal t.tabbedTxt, "<html>\n\t<head>\n\t\t<p></p>\n\t</head>\n</html>"
    # end

    # test "main loop style tag " do
    #   l = "<html>\n<head>\n<style>\np{\ncolor:red\n}\n</style>\n</head>\n</html>"
    #   t = Tabbing.new
    #   t.readLine l
    #   assert_equal t.tabbedTxt, "<html>\n\t<head>\n\t\t<style>\n\t\t\tp{\n\t\t\t\tcolor:red\n\t\t\t}\n\t\t</style>\n\t</head>\n</html>"
    # end

    # test "main loop script tag " do
    #   l = "<html>\n<head>\n<script>\np{color:red}\n</script>\n</head>\n</html>"
    #   t = Tabbing.new
    #   t.readLine l
    #   assert_equal t.tabbedTxt, "<html>\n\t<head>\n\t\t<script>\n\t\t\tp{color:red}\n\t\t</script>\n\t</head>\n</html>"
    # end
    
    # test "li_multi" do
    #    l = "<html>\n<head>\n<title>This is my first page</title>\n</head>\n<body>\n<ol>\n<li>\nFood\n<ul>\n<li>a</li>\n<li>b</li>\n<li>c</li>\n</ul>\n</li>\n<li>\nToy\n<ul>\n<li>1</li>\n<li>2</li>\n<li>3</li>\n</ul>\n</li>\n</ol>\n</body>\n</Html>"

    #    t = Tabbing.new
    #    t.readLine l

    #   ans = "<html>\n\t<head>\n\t\t<title>This is my first page</title>\n\t</head>\n\t<body>\n\t\t<ol>\n\t\t\t<li>\n\t\t\t\tFood\n\t\t\t\t\t<ul>\n\t\t\t\t\t<li>a</li>\n\t\t\t\t\t<li>b</li>\n\t\t\t\t\t<li>c</li>\n\t\t\t\t\t</ul>\n\t\t\t</li>\n\t\t\t<li>\n\t\t\t\tToy\n\t\t\t\t\t\t<ul>\n\t\t\t\t\t\t<li>1</li>\n\t\t\t\t\t\t<li>2</li>\n\t\t\t\t\t\t<li>3</li>\n\t\t\t\t\t</ul>\n\t\t\t</li>\n\t\t</ol>\n\t</body>\n</Html>"

    #   assert_equal t.tabbedTxt, ans
      
    # end

    test "li_multi" do
      l = "\t<li>\n\t</li>"
      t = Tabbing.new
      t.readLine l
      
      assert_equal t.tabbedTxt, "\t<li>\n\t</li>"
    end

    
  end
end
