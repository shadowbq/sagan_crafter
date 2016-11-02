# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sagan_crafter/version'

Gem::Specification.new do |spec|
  spec.name          = "sagan_crafter"
  spec.version       = SaganCrafter::VERSION
  spec.authors       = ["shadowbq"]
  spec.email         = ["shadowbq@gmail.com"]

  spec.summary       = %q{Write a short summary, because Rubygems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/shadowbq/sagan_crafter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bump", "~> 0.5"

  spec.add_dependency "snort-rule", "~> 1.5"
  spec.add_dependency "sqlite3", "~> 1.3"
  spec.add_dependency "xxhash", "~> 0.3"
  #spec.add_dependency "pry"
end
