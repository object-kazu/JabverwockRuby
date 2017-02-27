require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsDocument'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocumentTest < Test::Unit::TestCase
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
      @jsd = JsDocument.new("","","")
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

    # test "jsDocument first test, for print debug " do
    #   p @jsd
    # end

    test "select by id" do
      @jsd.attrBaseInit("koko","","")
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
    end
    
    test "select by class" do
      @jsd.attrBaseInit("koko","p","")
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
    end
    
    test "select by TagName" do
      @jsd.attrBaseInit("koko","p","popo")
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
      assert_equal(@jsd.byTagName.element, "document.getElementByTagName('popo');")
    end
    

    test "document write" do
      @jsd.attrBaseInit("koko","p","popo")
      a = @jsd.write "koko"
      assert_equal(a, "document.write('koko');")
    end

    test "innerHTML" do
      @jsd.attrBaseInit("koko","p","popo")
      a = @jsd.byID.innerHTML "aaa"
      assert_equal(a, "document.getElementById('koko').innerHTML=\"aaa\"")
    end

    test "attribute" do
      @jsd.attrBaseInit("koko","p","popo")
      a = @jsd.byID.attribute "aaa"
      assert_equal(a, "document.getElementById('koko').attribute=\"aaa\"")
    end
    


  end
end
