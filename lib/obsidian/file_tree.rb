require_relative 'tree'

class FileTree
  module Builder
    class << self
      def from_path(path)
        ft = Tree.new
        ft.content = path
        ft.name = File.basename(path)
        ft.root!

        files = Dir.glob(File.join(ft.content, "*"))

        build_tree(ft, files)
      end

      def build_tree(file_tree, files)
        # If there are no proximate files
        return file_tree if files.empty?

        # For each file adjacent to this file:
        #   Create a new child file tree
        #   Set its attributes up
        #   Make this file tree a child to the previous
        #   Recursively build the child file tree
        files.each do |child_path|
          child_ft = Tree.new
          child_ft.content = child_path
          child_ft.name = File.basename(child_path)
          file_tree.add_child(child_ft)

          child_files = Dir.glob(File.join(child_path, "*"))

          build_tree(child_ft, child_files)
        end

        return file_tree
      end
    end


    private_class_method :build_tree
  end
end
