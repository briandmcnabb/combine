# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'combine/version'

Gem::Specification.new do |spec|
  spec.name          = "combine"
  spec.version       = Combine::VERSION
  spec.authors       = ["Brian McNabb"]
  spec.email         = ["brian.d.mcnabb@gmail.com"]
  spec.description   = %q{Harvest the web while separating the grain from the chaff.}
  spec.summary       = %q{Harvest the web while separating the grain from the chaff.}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_dependency 'hashie',        '~> 2.0.5'
  spec.add_dependency 'crazy_harry',   '~> 0.1.2'
  spec.add_dependency 'proto_config',  '~> 0.0.1.alpha'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
