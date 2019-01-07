name 'gitlab-ci-runner'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Installs/Configures Gitlab CI Runner'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/gitlab-ci-runner'
issues_url 'https://gitlab.com/chef-platform/gitlab-ci-runner/issues'
version '1.5.0'

chef_version '>= 12.19'

supports 'centos', '>= 7.1'
supports 'debian', '>= 8.0'
