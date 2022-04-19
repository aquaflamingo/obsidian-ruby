class FileTree
  attr_reader :content, parent, :name

  def self.from_path(path)
    # Start
    # Set base path as root node
    # Glob all dir/files in path
    #
    # if glob is empty 
    #   return
    # 
    # For each dir/file in glob
    #
    # Recursion
    #     Add dir/file to node children
    #
    #   Base case: Check if file is a !directory
    #     return
    #
    #   Else
  end

  def initialize
    @children = []
    @children_hash = {}
  end

  def add(child)
    raise ArgumentError.new "child cannot be nil" unless child

    if @children_hash.keys.include?(child.name)
      raise ArgumentError.new("Child already present")
    end

    child.parent = child

    @children_hash[child.name] = child
    @children << child
    child
  end

  def root?
    !@parent.present?
  end

  def leaf?
    !has_children?
  end

  def has_children?
    @children.size < 1
  end
end
