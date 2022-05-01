require_relative "file_tree"

# 
# Vault is a representation of an Obsidian.md Vault Object
#
class Vault
  attr_reader :name

  def initialize(config, name)
    @config = config
    @name = name
    @fm = FileManager.new(@config.root_path)
  end

  def self.load(path, name)
    new(Config.new(path), name)
  end

  def new_dir(new_dir_path)
    @fm.new_dir(new_dir_path)
  end

  def new_file(new_file_path)
    @fm.new_file(new_file_path)
  end

  # 
  # Config represents a vaults configuration values for operating
  #
  class Config
    attr_reader :root_path, :config_path

    DEFAULT_CONFIG_LOCATION = '.obsidian'.freeze

    # 
    # For now, simply always assume default configuration file path
    #
    def initialize(path, config_path = DEFAULT_CONFIG_LOCATION)
      @config_path = File.join path, config_path

      @root_path = path
    end
  end

  # 
  # FileManager is an interface for accessing the in-memory
  # file tree of a vault.
  #
  class FileManager
    def initialize(root)
      @ft = FileTree::Builder.from_path(root)
    end

    def new_file(file_path)
      dir, base = File.split(file_path)

      # TODO:

    end

    def new_dir(dir_path)
      dir, base = File.split(file_path)

      # TODO:
    end
  end
end
