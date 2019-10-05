#
# Copyright:: Copyright 2016-2019, Chef Software Inc.
# Copyright:: Copyright 2019, Cinc Project
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require_relative "../../../lib/inspec/version.rb"

name "cinc-auditor"

dependency "ruby"
dependency "rubygems"
dependency "bundler"

license :project_license

default_version "v#{Inspec::VERSION}"

source path: "#{Omnibus::Config.project_root}/../",
       options: { exclude: ["omnibus"] }

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # Remove existing built gems in case they exist in the current dir
  delete "inspec-*.gem"
  delete "inspec-bin/#{name}-*.gem"

  # We bundle install to ensure the versions of gems we are going to
  # appbundle-lock to are definitely installed
  bundle "install --without test integration tools maintenance", env: env

  gem "build inspec.gemspec", env: env
  gem "install inspec-*.gem --no-document", env: env

  gem "build cinc-auditor-bin.gemspec", env: env, cwd: "#{project_dir}/inspec-bin"
  gem "install cinc-auditor-bin-*.gem --no-document", env: env, cwd: "#{project_dir}/inspec-bin"

  block do
    if Dir.exist?("#{project_dir}/inspec-bin")
      appbundle "cinc-auditor", lockdir: project_dir, gem: "cinc-auditor-bin", env: env
    else
      appbundle "cinc-auditor", env: env
    end
  end

  copy "#{project_dir}/cinc-auditor/cinc-auditor-wrapper", "#{install_dir}/bin/"
end
