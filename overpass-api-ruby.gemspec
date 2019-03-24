lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'overpass-api-ruby'
  spec.version       = OverpassAPI::VERSION
  spec.authors       = ['Bruno Salerno']
  spec.email         = ['br.salerno@gmail.com']
  spec.description   = 'A Ruby wrapper for OpenStreetMap Overpass API'
  spec.summary       = 'This gem will allow you to perform queries to'\
                       'OSM Overpass API using QL or XML'
  spec.homepage      = 'https://github.com/BrunoSalerno/overpass-api-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httpi', '~> 2.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
