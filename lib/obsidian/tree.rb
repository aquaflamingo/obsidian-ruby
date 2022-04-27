require 'forwardable'

class Tree
  extend Forwardable

  attr_accessor :content, :parent, :name
  def_delegator :@children, :[], :pick

  def initialize
    @children = []
    @children_hash = {}
  end

  def add_child(child)
    raise ArgumentError.new "child cannot be nil" unless child

    if @children_hash.keys.include?(child.name)
      raise ArgumentError.new("Child already present")
    end

    child.parent = child

    @children_hash[child.name] = child
    @children << child
    child
  end
  alias << :add_child

  def root!
    @parent = nil
  end

  def root?
    !@parent.present?
  end
  alias is_root? :root?

  def leaf?
    !has_children?
  end
  alias is_leaf? :leaf?

  def has_children?
    @children.size > 1
  end
end
