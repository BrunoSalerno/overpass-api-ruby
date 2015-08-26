# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'overpass_api_ruby'

Gem::Specification.new do |spec|
  spec.name          = "overpass-api-ruby"
  spec.version       = OverpassAPI::VERSION
  spec.authors       = ["Bruno Salerno"]
  spec.email         = ["br.salerno@gmail.com"]
  spec.description   = %q{A Ruby wrapper for OpenStreetMap Overpass API}
  spec.summary       = %q{Returns a Hash from a query}
  spec.homepage      = "https://github.com/BrunoSalerno/overpass-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httpi", "~> 2.4.0"
  spec.add_runtime_dependency "diskcached"
  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency("rspec", ">= 3")
end
