# TODO: Commentine artifactory source block temporarily
# to addres JIRA #9390 (Chef InSpec  Verify pipeline is failing due to checksum mismatch of mixlib-shellout gem)
# For Chef internal builds, allows preview versions of gems if available.
# if ENV["ARTIFACTORY_BASE_URL"]
#   source ENV["ARTIFACTORY_BASE_URL"] + "/artifactory/api/gems/omnibus-gems-local/" do
#     # TODO: either fully populate this list, or revert back to non-block format
#     #       to sweep all Chef gems from Artifactory.
#     gem "chef-licensing"
#   end
# end

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

# inspec tests depend text output that changed in the 3.10 release
# but our runtime dep is still 3.9+
gem "rspec", ">= 3.10"

# addressable 2.9.1 fixes seven URI and template advisories (GHSA-qq38-m9mg-xjj5
# and others); 2.9.2 also fixes 2.9.1's IDNA slowdown.
gem "addressable", ">= 2.9.2"
# rubyntlm 0.6.6 fixes the NTLMv2 verification bypass (GHSA-cx24-f932-rr55);
# 0.6.6 and 0.6.7 shipped broken, so 0.6.8 is the floor.
gem "rubyntlm", ">= 0.6.8"
# net-ssh 7.3.5 fixes seven advisories: host certificates (GHSA-vxj5-fg65-x765,
# already in 7.3.4), ProxyCommand, agent forwarding, and DoS by servers or keys;
# 7.3.8 completes 7.3.5's ProxyJump fix (GHSA-g2r2-x3p2-5677).
gem "net-ssh", ">= 7.3.8"

group :omnibus do
  gem "rb-readline"
  gem "appbundler"
  gem "ed25519" # ed25519 ssh key support done here as its a native gem we can't put in the gemspec
  gem "bcrypt_pbkdf" # ed25519 ssh key support done here as its a native gem we can't put in the gemspec
end

group :test do
  gem "chefstyle"
  gem "concurrent-ruby"
  gem "json_schemer"
  gem "m"
  gem "minitest-sprint", "~> 1.0"
  gem "minitest"
  gem "minitest-mock" # Ruby 3.4+ extracts minitest-mock to a separate gem (bundled gem). It's compatible with all Ruby versions.
  gem "mocha"
  gem "nokogiri"
  gem "pry-byebug"
  gem "pry"
  gem "rake", ">= 12.3.3"
  gem "simplecov"
  gem "simplecov_json_formatter"
  gem "webmock"
end

group :deploy do
  gem "inquirer"
end
