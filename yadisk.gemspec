# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yadisk/version"

Gem::Specification.new do |s|
  s.name          = "yadisk-client"
  s.version       = Yadisk::VERSION
  s.date          = "2014-12-23"
  s.summary       = "Yandex.Disk API client"
  s.description   = "Yandex.Disk API wrapper written in Ruby"
  s.authors       = ["Ilya Brin"]
  s.email         = "ilya@codeplay.ru"
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) {|f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage      = "http://rubygems.org/gems/yadisk-client"
  s.license       = "MIT"
  s.required_ruby_version = ">= 2.6"

  s.add_dependency "addressable", "~> 2.3", ">= 2.3.7"
  s.add_dependency "faraday", "~> 1.7"
  s.add_dependency "faraday_middleware", "~> 1.1"
end
