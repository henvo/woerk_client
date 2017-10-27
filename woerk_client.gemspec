# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "woerk_client/version"

Gem::Specification.new do |spec|
  spec.name          = "woerk_client"
  spec.version       = WoerkClient::VERSION
  spec.authors       = ["Henning Vogt"]
  spec.email         = ["git@henvo.de"]

  spec.summary       = %q{CLI for woerk.net}
  spec.description   = %q{Create and manage working shifts for woerk.net}
  spec.homepage      = "https://github.com/henvo/woerk_client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency "thor", "~> 0.20"
  spec.add_dependency "colorize", "~> 0.8.1"
  spec.add_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
  spec.add_development_dependency "simplecov", "~> 0.15.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
