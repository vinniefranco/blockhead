# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blockhead/version'

Gem::Specification.new do |spec|
  spec.name          = 'blockhead'
  spec.version       = Blockhead::VERSION
  spec.authors       = ['Vincent Franco']
  spec.email         = ['vince@freshivore.net']
  spec.summary       = 'A simple DSL for marshaling objects into a schema'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/vinniefranco/blockhead'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'
end
