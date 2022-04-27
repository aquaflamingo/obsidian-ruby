require 'forwardable'

#
# Tree is a basic tree data structure
#
class Tree
  extend Forwardable

  attr_accessor :content, :parent, :name
  def_delegator :@children, :[], :pick

  def initialize
    @children = []
    @children_hash = {}
  end

  # 
  # Adds a new child tree to this Tree
  #
  # @param child [Tree]
  #
  # @return Tree
  #
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


  # 
  # Sets this tree to the root 
  #
  # @return nil
  def root!
    @parent = nil
  end

  # 
  # Returns whether this tree is the root
  #
  # @return Boolean
  #
  def root?
    !@parent.present?
  end
  alias is_root? :root?

  # 
  # Returns whether this tree is a leaf
  #
  # @return Boolean
  #
  def leaf?
    !has_children?
  end
  alias is_leaf? :leaf?

  # 
  # Returns whether this tree possess any children
  #
  # @return Boolean
  #
  def has_children?
    @children.size > 1
  end
end
