project_root = File.dirname(__FILE__)
lib = File.join(project_root, 'lib')

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hellgrid/version'

Gem::Specification.new do |s|
  s.name          = 'hellgrid'
  s.version       = Hellgrid::VERSION
  s.date          = '2016-09-20'
  s.summary       = 'Gem version dependency matrix'
  s.authors       = ['Deyan Dobrinov', 'Aleksandar Ivanov']
  s.email         = ['engineering+hellgrid@fundingcircle.com']
  s.files         = Dir.chdir(project_root) { Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['exe/*'] + Dir['spec/**/*.rb'] + %w(Gemfile Gemfile.lock README.md hellgrid.gemspec) }
  s.bindir        = 'exe'
  s.executables   = s.files.grep(/^exe\//) { |f| File.basename(f) }
  s.test_files    = s.files.grep(/^spec\//)
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/FundingCircle/hellgrid'
  s.license       = 'BSD-3-Clause'

  s.add_runtime_dependency 'bundler', ['>= 1.11.0', '< 1.17']

  s.add_development_dependency 'rspec', '~> 3.7.0'
  s.add_development_dependency 'simplecov', '~> 0.16.0'
end
