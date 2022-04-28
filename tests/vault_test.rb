require_relative 'testing'

class VaultTest < Minitest::Test
  def setup
    path = File.join FileSystem.tmp_test_dir_path, 'vault_test'

    FileSystem.seed(path)

    @tmp_test_path = path
  end

  def test_load
    @v = Vault.load(@tmp_test_path, "Vault")

    assert_equal @v.name, "Vault"
  end
end
