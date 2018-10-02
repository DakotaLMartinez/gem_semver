
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gem_semver/version"

Gem::Specification.new do |spec|
  spec.name          = "gem_semver"
  spec.version       = GemSemver::VERSION
  spec.authors       = ["DakotaLMartinez"]
  spec.email         = ["dakotaleemusic@gmail.com"]

  spec.summary       = %q{Updates the version of your Gem (use in conjunction with rake release)}
  spec.description   = %q{Updates the version of your Gem (use in conjunction with rake release)Running `bump major` will result in a major version change, `bump minor` results in a minor version change, and `bump patch` results in a patch version change.}
  spec.homepage      = "https://github.com/DakotaLMartinez/gem_semver"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = ["bump"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
