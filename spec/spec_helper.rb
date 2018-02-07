require 'simplecov'
SimpleCov.start

require 'fileutils'
require 'hellgrid'
require 'hellgrid/project'
require 'hellgrid/matrix'
require 'hellgrid/views/console'

PROJECT_ROOT = File.expand_path('../..', __FILE__)

def create_file(path, content)
  full_path = File.join(PROJECT_ROOT, path)
  FileUtils.mkdir_p File.dirname(full_path)
  File.write(full_path, content)
end

def delete_tmp_folder
  FileUtils.rm_rf File.join(PROJECT_ROOT, '/spec/tmp')
end
