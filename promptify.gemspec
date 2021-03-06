lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "promptify/version"

Gem::Specification.new do |spec|
  spec.name = "promptify"
  spec.version = Promptify::VERSION
  spec.authors = ["Joey Cody"]
  spec.email = ["joey@fountain.com"]

  spec.summary = "Colorize staging/production rails console prompts with environment details"
  spec.homepage = "https://github.com/onboardiq/promptify"
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri"   => "https://github.com/onboardiq/promptify/issues",
    "changelog_uri"     => "https://github.com/onboardiq/promptify",
    "documentation_uri" => "https://github.com/onboardiq/promptify",
    "homepage_uri"      => "https://github.com/onboardiq/promptify",
    "source_code_uri"   => "https://github.com/onboardiq/promptify",
  }

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "pry"
  spec.add_dependency "pry-rails"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
