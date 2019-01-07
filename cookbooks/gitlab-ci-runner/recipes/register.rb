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

runners = node['gitlab-ci-runner']['runners']

runners.each do |runner|
  resource = gitlab_ci_runner runner['description'] do
    action runner['action'].nil? ? :register : runner['action']
  end

  runner.each do |name, value|
    resource.send(name.to_s, value)
  end
end
