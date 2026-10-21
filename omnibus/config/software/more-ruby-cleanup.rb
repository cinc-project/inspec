#
# Copyright (c) 2026 Cinc Project
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

require "fileutils"

name "more-ruby-cleanup"

skip_transitive_dependency_licensing true
license :project_license

source path: "#{project.files_path}/#{name}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  block "Removing vendored Gemfile.lock fixtures that trip SBOM scanners" do
    # Gems such as os and builder ship their dev Gemfile.lock. Nothing loads
    # them, but scanners report their pins as installed gems.
    Dir.glob("#{install_dir}/embedded/lib/ruby/gems/*/gems/*/**/Gemfile.lock".tr("\\", "/")).each do |f|
      gem_name = f[%r{/gems/[^/]+/gems/([^/]+)/}, 1]
      next if gem_name&.start_with?("inspec", "cinc-auditor")

      puts "Deleting #{f}"
      FileUtils.rm_f(f)
    end
  end

  # Make Ruby's default json the installed json gem, so nothing loads or
  # reports the older default copy.
  ruby "replace-default-json.rb", env: env
end
