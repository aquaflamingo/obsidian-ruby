# 
# Vault is a representation of an Obsidian.md Vault Object
#
class Vault
  def initialize(config)
    @config = config

    read_files
  end

  def self.load(path)
    new(Config.new(path, File.basename))
  end

  def new_folder
    raise NotImplementedError
  end

  def new_file
    raise NotImplementedError
  end

  private 

  class Config
    attr_reader :path, :name
    def initialize(path, name)
      @path = path
      @name = name
    end
  end
end
