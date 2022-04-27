require_relative 'tree'

class FileTree
  module Builder
    class << self
      def from_path(path)
        ft = Tree.new
        ft.content = path
        ft.name = File.basename(path)
        ft.root!

        build_tree(ft)
      end

      def build_tree(file_tree)
        # Look at all files proximal to this file
        files = Dir.glob(File.join(file_tree.content, "*"))

        # If there are no proximate files
        return if files.empty?

        # For each file adjacent to this file:
        #   Create a new child file tree
        #   Set its attributes up
        #   Make this file tree a child to the previous
        #   Recursively build the child file tree
        files.each do |f|
          binding.pry
          child_ft = Tree.new(f.path)
          child_ft.name = File.basename(f)
          file_tree.add_child(child_ft)

          build_tree(child_ft)
        end
      end
    end


    private_class_method :build_tree
  end
end
