require 'minitest/autorun'
require 'fileutils'
require 'pry'

require_relative '../lib/obsidian'


class FileSystem
  MockFile = Struct.new(:type, :name)
  MockDir = Struct.new(:type, :name, :children)

  FILE_STRUCTURE = [
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

  def self.tmp_test_dir_path
    File.join("/var","tmp","obsidian", "tests")
  end

  def self.seed(path)
    FileUtils.mkdir_p(path)

    FILE_STRUCTURE.each do |file_or_dir|
      created_file = File.join(path, file_or_dir.name) 

      if file_or_dir.type == :f
        FileUtils.touch(created_file) unless File.exist?(created_file)
      else
        FileUtils.mkdir(created_file) unless File.exist?(created_file)

        file_or_dir.children.each do |child_f|
          child_created_file = File.join(
            path, file_or_dir.name, child_f.name
          )

          FileUtils.touch(child_created_file) unless File.exist?(child_created_file)
        end
      end
    end
  end
end
