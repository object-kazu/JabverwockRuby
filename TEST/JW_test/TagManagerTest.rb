require 'test/unit'
require '../../GLOBAL/GlobalDef'# => true
require '../../GLOBAL/TagManager'# => true

class TagManagerTest < Test::Unit::TestCase
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
  
  test "TagManager, path confirm " do
    tm =  TagManager.new()
    tm.name = "first"

    assert_equal(tm.openString, "name=\"first\"")
    
  end
  
  test "TagManager, name is void " do
    tm =  TagManager.new()
    tm.name = ""

    assert_equal(tm.openString, "")
    
  end

  test "id add" do
    tm =  TagManager.new()
    tm.id = "test"

    assert_equal(tm.openString, "id=\"test\"")
    
  end

  test "id and name add" do
    tm =  TagManager.new()
    tm.id = "test"
    tm.name = "sample"

    assert_equal(tm.openString, "name=\"sample\" id=\"test\"")
    
  end

  test "class  add" do
    tm =  TagManager.new()
    tm.cls = "test"

    assert_equal(tm.openString, "class=\"test\"")
    
  end

  test "class, id , name  add" do
    tm =  TagManager.new()
    tm.cls = "test"
    tm.id = "test"
    tm.name = "sample"

    assert_equal(tm.openString, "name=\"sample\" id=\"test\" class=\"test\"" )

  end

  
end

# >> Loaded suite /var/folders/87/r0sr2xy176l6vnw1b8hffgtc0000gn/T/seeing_is_believing_temp_dir20170125-67391-ztt63u/program
# >> Started
# >> :_startup
# >> :setup
# >> :cleanup
# >> :treadown
# >> .:setup
# >> :cleanup
# >> :treadown
# >> .:_shutdown
# >> 
# >> 
# >> Finished in 0.00062 seconds.
# >> ------
# >> 2 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> ------
# >> 3225.81 tests/s, 3225.81 assertions/s
