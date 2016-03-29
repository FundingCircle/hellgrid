module BundlerDependencyMatrix
  class Matrix
    attr_reader :projects

    def initialize
      @projects = []
    end

    def add_project(project)
      @projects << project
    end

    def projects_sorted_by_name
      @projects.sort { |a,b| a.name <=> b.name }
    end

    def project_names
      projects_sorted_by_name.map(&:name)
    end

    def gem_names
      @projects.map { |p| p.dependency_matrix.keys }.flatten.uniq
    end

    def sorted_by_most_used
      header = [nil] + project_names

      body = gems_by_usage.keys.map do |gem|
        [gem] + projects_sorted_by_name.map { |project| project.dependency_matrix[gem] }
      end

      [header] + body
    end

    def gems_by_usage
      gem_usage = Hash.new(0)

      projects.each do |project|
        project.dependency_matrix.each do |gem, _|
          gem_usage[gem] += 1
        end
      end

      gem_usage.sort_by {|key, value| [-value, key] }.to_h
    end
  end
end
