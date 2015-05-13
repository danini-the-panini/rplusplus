# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rplusplus/version'

Gem::Specification.new do |spec|
  spec.name          = "rplusplus"
  spec.version       = Rplusplus::VERSION
  spec.authors       = ["Daniel Smith"]
  spec.email         = ["jellymann@gmail.com"]
  spec.summary       = %q{Making C++ slightly less painful.}
  spec.description   = %q{A collection of command-line tools for making C++ development easier.}
  spec.homepage      = "https://github.com/jellymann/rplusplus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "fakefs", "~> 0.6"
  spec.add_development_dependency "codeclimate-test-reporter"
end
