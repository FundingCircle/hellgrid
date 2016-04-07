lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hellgrid/version'

Gem::Specification.new do |s|
  s.name          = 'hellgrid'
  s.version       = Hellgrid::VERSION
  s.date          = '2016-03-28'
  s.summary       = 'Gem version dependecy matrix'
  s.description   = ''
  s.authors       = ['Deyan Dobrinov', 'Aleksandar Ivanov']
  s.email         = ['deyan.dobrinov@gmail.com', 'aivanov92@gmail.com']
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.homepage      = 'http://github.com/FundingCircle/hellgrid'
  s.license       = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'bundler', '~> 1.11', '>= 1.11.0'
end
