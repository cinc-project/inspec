require "helper"
require "inspec/fetcher"
require "tmpdir"

describe Inspec::Fetcher::Gem do
  let(:fetcher) { Inspec::Fetcher::Gem }

  it "registers with the fetchers registry" do
    reg = Inspec::Fetcher::Registry.registry
    _(reg["gem"]).must_equal fetcher
  end

  it "resolves a target hash with a gem key" do
    res = fetcher.resolve({ gem: "some-resource-pack" })
    _(res).must_be_kind_of fetcher
  end

  it "does not resolve a target hash without a gem key" do
    _(fetcher.resolve({ url: "https://example.com/profile.tgz" })).must_be_nil
  end

  describe "when the gem is already installed in the current Ruby" do
    # minitest is certain to be loadable in the test process, making it a
    # stand-in for a resource-pack gem bundled alongside InSpec.
    let(:system_gem) { "minitest" }
    let(:system_gem_dir) { ::Gem::Specification.find_by_name(system_gem).full_gem_path }
    let(:res) { fetcher.resolve({ gem: system_gem }) }

    it "fetches from the system gem instead of installing" do
      Inspec::Plugin::V2::Installer.instance.stubs(:plugin_installed?).returns(false)
      Inspec::Plugin::V2::Installer.instance.expects(:install).never

      Dir.mktmpdir do |cache_dir|
        res.fetch(cache_dir)
        copied = File.join(cache_dir, File.basename(system_gem_dir))
        _(File.directory?(copied)).must_equal true
      end
    end

    it "reports the system gem version in resolved_source" do
      Inspec::Plugin::V2::Loader.stubs(:find_gemspec_of).returns(nil)
      expected = ::Gem::Specification.find_by_name(system_gem).version.to_s
      _(res.resolved_source[:version]).must_equal expected
    end
  end

  describe "when the gem is not installed anywhere" do
    let(:res) { fetcher.resolve({ gem: "not-a-real-inspec-resource-pack" }) }

    it "falls back to a plugin install" do
      Inspec::Plugin::V2::Installer.instance.stubs(:plugin_installed?).returns(false)
      Inspec::Plugin::V2::Installer.instance.expects(:install)
        .with("not-a-real-inspec-resource-pack", version: nil, source: nil, gem: "not-a-real-inspec-resource-pack")

      res.fetch(nil)
    end
  end
end
