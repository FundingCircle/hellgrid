# frozen_string_literal: true

module Hellgrid
  class CLI
    def self.start(argv = ARGV)
      new(argv).start
    end

    def initialize(argv = ARGV)
      @argv = argv
    end

    attr_reader :argv

    def start
      recursive_search = !argv.delete('-r').nil?
      transpose = !argv.delete('-t').nil?

      folders = argv.empty? ? [Dir.pwd] : argv

      folders.each do |folder|
        matrix = Hellgrid::Matrix.new

        Find.find(folder) do |path|
          if File.directory?(path) && File.exist?(File.join(path, 'Gemfile.lock'))
            matrix.add_project(Hellgrid::Project.new(folder, path))
            Find.prune unless recursive_search
          end
        end

        data = matrix.sorted_by_most_used
        data = data.transpose if transpose

        view = Hellgrid::Views::Console.new(data)

        view.render
      end
    end
  end
end
