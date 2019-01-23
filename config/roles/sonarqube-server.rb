name "sonarqube-server"
description "Installs and configure sonarqube server"

default_attributes(
  "java" => {
    "install_flavor" => "openjdk",
    "jdk_version" => "8"
  }
)

run_list "recipe[basics]", "recipe[java]", "recipe[postgresql]","recipe[sonarqube]", 'recipe[firewalld]', 'recipe[firewalld::sonarqube]', 'recipe[sonarqube::scanner]'
