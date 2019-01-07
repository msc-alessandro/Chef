Gitlab CI Runner
================

Description
-----------

Install and configure *runners* for **gitlab-ci**. Use
**gitlab-ci-multi-runner** as runner type. Learn more on
<https://gitlab.com/gitlab-org/gitlab-ci-multi-runner>.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos
- Debian 8

Usage
-----

### Easy Setup

Add `recipe[gitlab-ci-runner]` in your run-list to install
**gitlab-ci-multi-runner** using its repository.

To add runners, use default provider or use
`recipe[gitlab-ci-runner::register]` and `runners` attribute. To see a use
case, look at [.kitchen.yml](.kitchen.yml).

### Test

This cookbook is fully tested through the installation of the full gitlab
platform in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run kitchen list, you will see 3 suites, Each corresponds to a different
server:

- kitchen-gitlab-ubuntu-1404: complete instance of **gitlab-ce**
- kitchen-gitlab-ci-runner-centos-7: installation of **gitlab-ci-multi-runner**
  and configuration of runners on a centos-7
- kitchen-gitlab-ci-runner-debian-8: same but for debian-8

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Install **gitlab-ci-multi-runner** by using its repository, enable and start
the service.

### repository

Install runner repository.

### package

Install **gitlab-ci-multi-runner** package.

### service

Enable and start runner service.

### register

Register or Unregister runners based on attribute
`['gitlab-ci-runner']['runners']`. This is an Array of Hash where each Hash
represent an action on a runner, "register" or "unregister". In a Hash,
`description` key is the name attribute and represents the name of the runner.
Then each runner option should be listed in a sub-Hash of key `options`, each
sub-key matching an option name of gitlab-runner cli.

See [.kitchen.yml](.kitchen.yml) for an example.

Resources/Providers
-------------------

### default

Register or Unregister runners. For instance, to register a default runner
to http://gitlab-ci.myinstance:

```ruby
gitlab_ci_runner 'my runner' do
  options({
    registration_token: '1234567890',
    url: 'http://gitlab-ci.myinstance'
  })
end
```

The options list with full documentation is available in
[resources/default.rb](resources/default.rb).

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG.md).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2015-2017 Sam4Mobile, 2017 Make.org

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
