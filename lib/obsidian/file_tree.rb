class FileTree
  attr_accessor :content, parent, :name

  class Builder
    # TODO make builder
    def add(ft)
      # Look at all files proximal to this file
      files = Dir.glob(File.join(path, "*"))

      # If there are no proximate files
      if files.empty?
        return

      files.each do |f|
        child_ft = FileTree.new
        child_ft.name = File.basename(f)
        child_ft.content = f

        ft.add_child(child_ft)

        add(ft)
      end
    end

    def from_path(path)
      ft = new 

      ft.root!

      add(ft)

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
  end


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

  def root!
    @parent = nil
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
