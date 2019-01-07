#
# Copyright (c) 2015-2017 Sam4Mobile, 2017 Make.org
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

# Set cookbook_name "macro"
cookbook_name = 'gitlab-ci-runner'

# Version of gitlab-ci-runner package
# Default is latest so it will be upgraded automatically
default[cookbook_name]['version'] = 'latest'

# Describe a list of runners to register or unregister
# See .kitchen.yml for an example
default[cookbook_name]['runners'] = []

# Configure repository, you can override just 'repository_base_url' or
# the entire 'repository_url' if needed
default[cookbook_name]['repository_base_url'] =
  'https://packages.gitlab.com/runner/gitlab-runner'
default[cookbook_name]['repository_url'] = nil
default[cookbook_name]['gpg_key'] =
  'https://packages.gitlab.com/runner/gitlab-runner/gpgkey'

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
