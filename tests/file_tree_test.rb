require_relative 'testing'

class FileTreeTest < Minitest::Test
  class FileTreeBuilderTest < Minitest::Test

    def setup
      path = File.join FileSystem.tmp_test_dir_path, "file_tree_test"

      FileSystem.seed(path)

      @tmp_test_path = path
    end

    def test_from_path
      ft = FileTree::Builder.from_path(@tmp_test_path)

      assert ft.has_children?, true
      assert ft.root?, true
    end
  end
end
