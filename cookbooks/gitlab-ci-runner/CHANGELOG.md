Changelog
=========

1.5.0
-----

Main:

- update repository url and package name to match version > 10
  + set minimal version support to 10+
- feat: add amazon platform to yum repo configuration

Misc:

- style: replace updated\_by\_last\_action by converge\_by
- style(rubocop): fix offenses (heredoc and rescue)
- chore: add foodcritic & rubocop in Gemfile

1.4.0
-----

Main:

- add Debian support
- fix #2: gitlab-runner pkg version is configurable
- fix(debian): set package retries only when non nil
- fix: conflict with apt cookbook on resource name

Tests:

- increase max wait time of gitlab to 5 min (better resilience on shared
  runners)
- use .gitlab-ci.yml template [20170731]
- sleep 2s in tests after runner actions (for shared runner)

Misc:

- set new contributing guide with karma style
- remove dependency on yum, set chef version to 12.19

1.3.0
-----

Main:

- Add official support (with tests) for debian 8
- Fix wait when error is 500 (or anything else)
- Fix escape tag-list argument
- Fix escape bool arguments properly
- Handover maintenance to Make.org, update Copyright

Tests:

- Stop always executing a converge before a verify
- Add always\_update\_cookbooks: true in provisionner config
- Use latest template for .gitlab-ci.yml [20170405]
- Set build\_pull: download latest test image
- Use preprovisionned image with chef for gitlab
- Make tests work on gitlab shared runner: get around the selinux security

Misc:

- Fix mistake on provider example in README
- Fix all rubocop and foodcriti offenses
- Use cookbook\_name "macro" everywhere
- Fix missing/wrong metadata, set chef-version (>= 12.0)

1.2.0
-----

Main:

- Fix #2: multiple tags are now correctly handled
- Fix #3: ruby\_block resource is always run
- Fix #6: Make repo URL and gpgkey an attribute
- Fix #7: Support multiple env strings
- Add ChefSpec matchers for LWRP

Tests:

- Switch to kitchen-docker\_cli instead of kitchen-docker
- Clean kitchen.yml, use instance names & add skip\_preparation
- Add tags in gitlab-ci tests
- Use Continuous Integration with gitlab-ci
- Can specify retries in package, set 1 in tests

1.1.0
-----

Main:

- Fix cookbook to work with latest available version of gitlab (8.5) and
  gitlab-runner (1.0.4)
- Be completely generic and accept any runner options
  + rename token to registration\_token to match runner cli option name

Tests:

- Change kitchen driver to docker\_cli
- Use official docker image for gitlab
- Remove useless monkey patching

Misc:

- Fix all rubocop offenses
- Add license, refactor README and update it
- Add default attribute 'runners' with a small documentation

1.0.0
-----

- Initial version with Centos 7 support
