
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'm2y_ercard/version'

Gem::Specification.new do |spec|
  spec.name          = "m2y_ercard"
  spec.version       = M2yErcard::VERSION
  spec.authors       = ["Danilo Sobral"]
  spec.email         = ["danilo.sobral@mobile2you.com.br"]

  spec.summary       = %q{ER Card Gem}
  spec.description   = %q{ER Card Gem}
  spec.homepage      = "http://www.mobile2you.com.br"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "openssl"
end
