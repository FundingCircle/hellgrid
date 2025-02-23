# frozen_string_literal: true

project_root = File.dirname(__FILE__)
lib = File.join(project_root, 'lib')

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hellgrid/version'

Gem::Specification.new do |s|
  s.name          = 'hellgrid'
  s.version       = Hellgrid::VERSION
  s.summary       = 'Gem version dependency matrix'
  s.description   = 'Display gem versions used across your projects in a table'
  s.authors       = ['Deyan Dobrinov', 'Aleksandar Ivanov']
  s.email         = ['engineering+hellgrid@fundingcircle.com']
  s.files         = Dir.chdir(project_root) do
    Dir['lib/**/*.rb'] +
      Dir['bin/*'] +
      Dir['exe/*'] +
      Dir['spec/**/*.rb'] +
      %w[Gemfile Gemfile.lock README.md hellgrid.gemspec]
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^spec/})
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/FundingCircle/hellgrid'
  s.license       = 'BSD-3-Clause'

  s.required_ruby_version = '>= 3.1.0'

  s.add_runtime_dependency 'bundler', '>= 1.11.0', '< 3'

  s.add_development_dependency 'rspec', '~> 3.13'
end
