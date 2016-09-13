project_root = File.dirname(__FILE__)
lib = File.join(project_root, 'lib')

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hellgrid/version'

Gem::Specification.new do |s|
  s.name          = 'hellgrid'
  s.version       = Hellgrid::VERSION
  s.date          = '2016-03-28'
  s.summary       = 'Gem version dependency matrix'
  s.description   = ''
  s.authors       = ['Deyan Dobrinov', 'Aleksandar Ivanov']
  s.email         = ['deyan.dobrinov@gmail.com', 'aivanov92@gmail.com']
  s.files         = Dir.chdir(project_root) { Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir['spec/**/*.rb'] + %w(Gemfile Gemfile.lock README.md hellgrid.gemspec) }
  s.executables   = s.files.grep(/^bin\//) { |f| File.basename(f) }
  s.test_files    = s.files.grep(/^spec\//)
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/FundingCircle/hellgrid'
  s.license       = 'MIT'

  s.required_ruby_version = '>= 2.3.1'
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'bundler', '~> 1.11', '>= 1.11.0'
end
