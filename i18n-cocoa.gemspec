# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n/cocoa/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n-cocoa"
  spec.version       = I18n::Cocoa::VERSION
  spec.authors       = ["Hirohisa Kawasaki", "Shiya Keita"]
  spec.email         = ["hirohisa.kawasaki@gmail.com", "keita.shiya@gmail.com"]
  spec.summary       = %q{Manage translation and localization}
  spec.description   = %q{Manage translation and localization with static analysis, for iOS}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob("{lib,spec}/**/**") + %w(README.md LICENSE)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
