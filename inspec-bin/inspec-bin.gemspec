lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "inspec-bin/version"

Gem::Specification.new do |spec|
  spec.name          = "inspec-bin"
  spec.version       = InspecBin::VERSION
  spec.authors       = ["Chef InSpec Core Engineering "]
  spec.email         = ["inspec@chef.io"]
  spec.summary       = "Infrastructure and compliance testing."
  spec.description   = <<-EOT
InSpec executable for inspec gem.

This is the Cinc Auditor build of this gem, distributed by the Cinc Project under the Apache-2.0 license.

  EOT

  spec.homepage      = "https://github.com/inspec/inspec/tree/main/inspec-bin"
  spec.license       = "Apache-2.0"

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.1.0"

  spec.add_dependency "inspec", "= #{InspecBin::VERSION}"
  spec.add_development_dependency "rake", ">= 12.3.3"

  spec.files = %w{README.md LICENSE Gemfile} + Dir.glob("*.gemspec") +
    Dir.glob("{lib,bin}/**/*", File::FNM_DOTMATCH).reject { |f| File.directory?(f) }

  spec.bindir = "bin"
  spec.executables = %w{inspec}

end
