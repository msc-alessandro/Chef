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

include_recipe "#{cookbook_name}::repository"
include_recipe "#{cookbook_name}::package"
include_recipe "#{cookbook_name}::service"

$CHAKE_ENV = ENV.fetch('CHAKE_ENV', 'local')
$ROOT_DIR = File.expand_path('../../../../../.', __FILE__)

config_file = "#{$ROOT_DIR}/config/#{$CHAKE_ENV}/%s"

runners_file = config_file % 'runners.yaml'
runners = YAML.load_file(runners_file)
puts runners['runners']

task_name = 'Create runner %s'


runners['runners'].each do |runner|

  gitlab_ci_runner task_name % runner['description'] do
      options({
          registration_token:  runner['options']['registration_token'],
          url: runner['options']['url'],
          executor: runner['options']['executor'],
          :'docker-image' => runner['options']['docker_image'],
          :'tag-list' => runner['options']['tag_list']
      })
  end

end




