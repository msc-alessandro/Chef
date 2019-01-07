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

require 'spec_helper'

gitlab_runner = 'http_proxy="" HTTP_PROXY="" gitlab-runner'

describe 'Gitlab CI Runner' do
  it 'should have a runner alive' do
    verify = `#{gitlab_runner} verify 2>&1`
    regexp = /Verifying runner\.\.\. is alive/
    expect(verify).to match(regexp)
  end
end

env_opt = 'environment = \["PATH=\$\{PATH\}:/opt/chefdk/embedded/bin/", ' \
  '"BERKSHELF_PATH=/dev/shm/foo/.berkshelf"\]'
describe 'Runner configuration' do
  context file('/etc/gitlab-runner/config.toml') do
    its('content') { should contain env_opt }
  end
end
