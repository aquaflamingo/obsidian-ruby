require_relative 'testing'

class TreeTest < Minitest::Test 
  class TreeFactory 
    def self.build(name:, content:)
      t1 = Tree.new

      t1.name = name
      t1.content = content

      t1
    end
  end

  def setup
    @tree = Tree.new
  end

  def test_add_child
    @tree.add_child(Tree.new)

    assert @tree.has_children?, true
  end

  def test_pick
    t1 = TreeFactory.build(name: "t1", content: "content1")
    t2 = TreeFactory.build(name: "t2", content: "content2")

    @tree << t1
    @tree << t2

    assert_equal @tree.pick(0), t1
  end
end

