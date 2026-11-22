source "https://rubygems.org"

gem "inspec", path: "."

# This dependency is NOT used for normal gem deployment
# - instead, inspec-bin gemspec-depends on inspec
#
# However, AppBundler requires a top-level Gemfile.lock with inspec-bin
# in it in order to package the executable. Hence the odd backwards dependency.
gem "cinc-auditor-bin", path: "./inspec-bin"

# ffi version v1.17.0 is breaking verify pipeline as it requires
# rubygems version to be upgraded to >= 3.3.22 Ref:https://buildkite.com/chef/inspec-inspec-main-verify-private/builds/812#018fe177-2ccb-45ed-a25e-213c8a6453df/698-707

gem "ffi", ">= 1.15.5", "< 1.17.0"

# We have a build issue 2023-11-13 with unf_ext 0.0.9 so we are pinning to 0.0.8.2
# See https://github.com/knu/ruby-unf_ext/issues/74 https://buildkite.com/chef/inspec-inspec-inspec-5-omnibus-release/builds/22
gem "unf_ext", "= 0.0.8.2"

# inspec tests depend text output that changed in the 3.10 release
# but our runtime dep is still 3.9+
gem "rspec", ">= 3.10"

# net-ssh 7.3.10 fixes the remaining SSH client advisories and faraday 1.10.6 fixes
# the redirect advisories.
gem "net-ssh", ">= 7.3.10"
gem "faraday", ">= 1.10.6"
# addressable 2.9.1 fixes seven URI and template advisories (GHSA-qq38-m9mg-xjj5
# and others); 2.9.2 also fixes 2.9.1's IDNA slowdown.
gem "addressable", ">= 2.9.2"
# rubyntlm 0.6.6 fixes the NTLMv2 verification bypass (GHSA-cx24-f932-rr55);
# 0.6.6 and 0.6.7 shipped broken, so 0.6.8 is the floor.
gem "rubyntlm", ">= 0.6.8"
# json 2.19.9 fixes GHSA-x2f5-4prf-w687.
gem "json", ">= 2.19.9"
# rubyzip 3.4 fixes the path traversal in CVE-2026-85396 (GHSA-47m2-wp7j-p9vc).
# Without this floor chef-winrm-fs 1.4.2 keeps rubyzip on 2.x.
gem "rubyzip", ">= 3.4"

group :omnibus do
  gem "rb-readline"
  gem "appbundler"
  gem "ed25519" # ed25519 ssh key support done here as its a native gem we can't put in the gemspec
  gem "bcrypt_pbkdf" # ed25519 ssh key support done here as its a native gem we can't put in the gemspec
  # pinning at < 0.6, 0.6 requires ruby 3.2+, InSpec5 does not support Ruby 3.2
  gem "net-imap", ">= 0.5.14", "< 0.6"
end

group :test do
  gem "chefstyle"
  # concurrent-ruby 1.3.7 fixes GHSA-h8w8-99g7-qmvj and two Low advisories.
  gem "concurrent-ruby", ">= 1.3.7"
  gem "json_schemer"
  gem "m"
  # 1.4.0+ requires min ruby 3.2, InSpec5 does not support Ruby 3.2
  gem "minitest-sprint", "~> 1.3.0" , "< 1.4.0"
  gem "minitest", "5.15.0"
  gem "mocha"
  gem "nokogiri", "~> 1.18.10"
  gem "pry-byebug"
  gem "pry"
  gem "rake"
  gem "simplecov"
  gem "simplecov_json_formatter"
  gem "webmock"
  gem "signet", "< 0.22.0" # 0.20.0+ requires min ruby 3.1
  # Pinning to 1.15 as multi_json 1.16 require ruby 3.2 version
  # Ref: https://buildkite.com/chef-oss/inspec-inspec-inspec-5-verify/builds/647#019808ca-087b-43bc-b1f9-40a36f59c5f4
  gem "multi_json", "~> 1.18.0"
end

group :deploy do
  gem "inquirer"
end

# Build is failing - see: https://buildkite.com/chef-oss/inspec-inspec-inspec-5-verify/builds/442
# Error: zeitwerk-2.7.1 requires Ruby >= 3.2, which is incompatible with the current version (Ruby 3.0.7p220)
# Dependency chain:
# zeitwerk → dry-configurable, dry-struct, dry-types → k8s-ruby → train-kubernetes
# Pinning zeitwerk to ~> 2.6 to avoid Ruby >= 3.2 requirement.
# Remove this pin when upgrading to Ruby 3.2 or higher.
gem "zeitwerk", "~> 2.6.0", "< 2.7"

# Pinning connection_pool to < 3.0.0 as 3.0.0+ requires Ruby >= 3.2.0
gem "connection_pool", ">= 2.5", "< 3.0"
