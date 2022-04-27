require_relative 'testing'

class FileTreeTest < Minitest::Test
  class FileTreeBuilderTest < Minitest::Test
    MockFile = Struct.new(:type, :name)
    MockDir = Struct.new(:type, :name, :children)

    TREE_STRUCTURE = [
      MockFile.new(:f, "file1"),
      MockFile.new(:f, "file2"),
      MockDir.new(:d, "dir1", [
        MockFile.new(:f, "file3"),
        MockFile.new(:f, "file4")
      ]),
      MockDir.new(:d, "dir2", [
        MockFile.new(:f, "file5"),
      ])
    ]

    def tmp_test_path
      File.join("/var","tmp","obsidian", "tests", "file_tree_builder_test")
    end

    def setup
      FileUtils.mkdir_p(tmp_test_path)

      TREE_STRUCTURE.each do |file_or_dir|
        created_file = File.join(tmp_test_path, file_or_dir.name) 

        if file_or_dir.type == :f
          FileUtils.touch(created_file) unless File.exist?(created_file)
        else
          FileUtils.mkdir(created_file) unless File.exist?(created_file)

          file_or_dir.children.each do |child_f|
            child_created_file = File.join(
              tmp_test_path, file_or_dir.name, child_f.name
            )

            FileUtils.touch(child_created_file) unless File.exist?(child_created_file)
          end
        end
      end
    end

    def test_from_path
      ft = FileTree::Builder.from_path(tmp_test_path)

      assert ft.has_children?, true
      assert ft.root?, true
    end
  end
end
