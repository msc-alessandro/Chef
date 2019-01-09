
name "gitlab-runner"
description "Install and configure gitlab runner server"
run_list "recipe[basics]", "recipe[docker]", "recipe[firewalld]", "recipe[gitlab-ci-runner]"
