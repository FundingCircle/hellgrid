module Hellgrid
  class Project
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def name
      File.basename(File.expand_path(path))
    end

    def dependency_matrix
      @dependency_matrix ||= specs.inject(Hash.new) { |h,spec| h.merge!(spec.name.to_s => spec.version.version) }
    end

    private

    def lockfile
      File.join(@path, 'Gemfile.lock')
    end

    def parsed_lockfile
      Bundler::LockfileParser.new(Bundler.read_file(lockfile))
    end

    def specs
      parsed_lockfile.specs
    end
  end
end
