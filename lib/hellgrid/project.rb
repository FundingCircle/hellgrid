# frozen_string_literal: true

module Hellgrid
  class Project
    attr_reader :path

    def initialize(root, path)
      @root = root
      @path = path
    end

    def name
      File.expand_path(path).gsub("#{File.expand_path(root)}/", '')
    end

    def dependency_matrix
      @dependency_matrix ||= specs.inject({}) { |h, spec| h.merge!(spec.name.to_s => spec.version.version) }
    end

    private

    attr_reader :root

    def lockfile
      File.join(path, 'Gemfile.lock')
    end

    def parsed_lockfile
      Bundler::LockfileParser.new(Bundler.read_file(lockfile))
    end

    def specs
      parsed_lockfile.specs
    end
  end
end
