name 'test-gitlab-ci-runner'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache 2.0'
description 'Helper Cookbook to test Gitlab CI Runner'
long_description 'Helper Cookbook to test Gitlab CI Runner'
source_url 'https://gitlab.com/chef-platform/gitlab-ci-runner'
issues_url 'https://gitlab.com/chef-platform/gitlab-ci-runner/issues'
version '1.0.0'

chef_version '>= 12.0'

supports 'centos', '>= 7.1'

depends 'gitlab-ci-runner'
