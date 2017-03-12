require 'test/unit'

require '../../lib/css/css'

require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/global/jwMulti"
require "../../lib/global/jwOneTag"
require "../../lib/global/jwSingle"
require "../../lib/global/jwTable"
require "../../lib/global/jw_CSS"
require "../../lib/global/jw_CSS_JS"
require "../../lib/global/press"


module Jabverwock
  using StringExtension
  
  class HTML_cssTest < Test::Unit::TestCase
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

    test "css html first test, for print debug " do
      # p CSS.new "t"
      # p HEAD.new

      
    end

    test "set css property" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size = 10
      assert_equal(h.css.str, "head {\n\tfont-size: 10;\n}")
    end
    
    test "set css property case 2" do
      h = HEAD.new().contentIs "this is test"
      h.css.font_size("10")
      assert_equal(h.css.str, "head {\n\tfont-size: 10;\n}")
    end
    
    test "add css property not" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c
      a = h.assembleTabedCss
      
      assert_equal(a.removeAllTab, "head {\nfont-size: 10;\n}")
    end
    
    test "add css property , different name" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "p"
      c.font_size = 10
      p c.str
      
      h.addCss c
      a = h.assembleTabedCss
      
      assert_equal(a.removeAllTab, "p {\nfont-size: 10;\n}")
    end

    
    test "add css property" do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end

    test "addHead" do 
      a = "a\n" + "b\n"
      ans = KString.addTabEachLine(a)
      assert_equal(ans, "\ta\n\tb\n")
    end
    
    test "add member " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new
      body.css.color "red"

      h.addMember body
      
      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("\tbody {\n\t\t\t\tcolor: red;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end

    test "set id, selector id " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new.attr(:id, "sample")
      body.css.color "red"

      h.addMember body
            
      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("\tbody #sample {\n\t\t\t\tcolor: red;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end

    test "set cls, selector cls " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new.attr(:cls, "sample")
      body.css.color "red"

      h.addMember body
            
      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("\tbody .sample {\n\t\t\t\tcolor: red;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end

    test "set cls. id, selector cls,id " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new.attr(:cls, "sample").attr(:id, "test")
      body.css.color "red"

      h.addMember body
            
      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("\tbody #test .sample {\n\t\t\t\tcolor: red;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end


    test "check child, set cls. id, selector cls,id " do
      h = HEAD.new().contentIs "this is test"
      c = CSS.new "head"
      c.font_size = 10
      h.addCss c

      body = BODY.new.attr(:cls, "sample").attr(:id, "test")
      body.css.color "red"

      h.addChild body
            
      pressed = h.pressDefault
      
      assert_true(pressed.include?("<style>\n"))
      assert_true(pressed.include?("\thead {\n\t\t\t\tfont-size: 10;\n\t\t\t}\n"))
      assert_true(pressed.include?("\tbody #test .sample {\n\t\t\t\tcolor: red;\n\t\t\t}\n"))
      assert_true(pressed.include?("</style>"))

    end

    
  end

end
