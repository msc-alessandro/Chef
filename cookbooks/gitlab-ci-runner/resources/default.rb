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

actions :register, :unregister
default_action :register

# Description (name of runner), url and config_file default
attribute :description, kind_of: String, name_attribute: true
attribute :url, kind_of: String, default: 'https://ci.gitlab.com/'
attribute :config, kind_of: String, default: '/etc/gitlab-runner/config.toml'
# Unset http_proxy env variables, probably only useful for kitchen
attribute :unset_proxy, kind_of: [TrueClass, FalseClass], default: false
# sleeping after doing an action (make tests more reliable)
attribute :sleep, kind_of: Integer, default: 0

# Define options listed by gitlab-runner help register (or unregister)
# Options is a hash like: { 'option_name' => 'option_value' }
# Option names are assumed to begin by '--' so you must use complete names
# You can redefined description, url and config
# Note: all occurences of character '_' are replaced by '-'
attribute :options, kind_of: Hash, default: {}
