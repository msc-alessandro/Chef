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

use_inline_resources

action :register do
  if runner_token(new_resource.description, new_resource.config).nil?
    defaults = {}
    %i[description url config].each do |key|
      defaults[key.to_s] = new_resource.send(key)
    end
    options_hash = defaults.merge(new_resource.options.to_hash)
    options = feed_options(options_hash).join(' ')

    env = ''
    if new_resource.unset_proxy
      env = 'http_proxy="" https_proxy="" HTTP_PROXY="" HTTPS_PROXY=""'
    end

    converge_by("Register runner #{new_resource.description}") do
      execute "#{env} gitlab-runner register --non-interactive #{options}"
      # giving time to gitlab-ci to manage the request
      execute "sleep #{new_resource.sleep}"
    end
  end
end

action :unregister do
  options = feed_options(new_resource.options)
  token, url = runner_token(new_resource.description, new_resource.config)
  options << "--token #{token} --url #{url}"
  options = options.join(' ')

  env = ''
  if new_resource.unset_proxy
    env = 'http_proxy="" https_proxy="" HTTP_PROXY="" HTTPS_PROXY=""'
  end

  unless url.nil?
    converge_by("Unregister runner #{new_resource.description}") do
      execute "#{env} gitlab-runner unregister #{options}"
      # giving time to gitlab-ci to manage the request
      execute "sleep #{new_resource.sleep}"
    end
  end
end

def feed_options(options_hash)
  options = []
  options_hash.each_pair do |key, value|
    keyname = key.to_s.tr('_', '-')
    options.concat(transform_option(keyname, value))
  end
  options
end

def transform_option(key, value)
  if value.is_a?(TrueClass) || value.is_a?(FalseClass)
    return ["--#{key}=#{value}"]
  end
  return ["--#{key} '#{value}'"] unless value.is_a?(Array)
  return ["--#{key} '#{value.join(',')}'"] if key == 'tag-list'
  value.map { |item| "--#{key} '#{item}'" }
end

def toml_parse(file)
  chef_gem 'toml' do
    compile_time true
  end
  require 'toml'
  toml = {}
  toml = ::TOML.load_file(file) if ::File.file? file
  toml['runners'] ||= []
  toml
end

def runner_token(description, config_file)
  config = toml_parse config_file
  config['runners'].reverse.each do |r|
    return [r['token'], r['url']] if r['name'] == description
  end
  nil
end
