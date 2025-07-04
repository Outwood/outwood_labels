# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "outwood_labels/version"

Gem::Specification.new do |spec|
  spec.name          = "outwood_labels"
  spec.version       = OutwoodLabels::VERSION
  spec.authors       = ["Tom Crouch"]
  spec.email         = ["t.crouch@outwood.com"]

  spec.summary       = "Sticker generator"
  spec.homepage      = "https://github.com/outwood/outwood_labels"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "csv", "~> 3.0"
  spec.add_dependency "prawn-label_sheet", "~> 0.2"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
