#-*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

env = ENV.fetch('ENV', 'local')      # { local, dev }


Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  #config.vm.box = "senglin/win-10-enterprise-vs2015community"

  config.vm.box_check_update = false

  if File.exist?("config/#{env}/ips.yaml")
    ips = YAML.load_file("config/#{env}/ips.yaml")
  else
    ips = nil
  end

  config.vm.define 'gitlab-runner' do |gitlab|
    gitlab.vm.provider "virtualbox" do |vm, override|
      override.vm.network 'private_network', ip: ips['gitlab-runner'] if ips
      override.vm.synced_folder '.', '/home/vagrant/sync', disabled: true
      override.vm.synced_folder '.', '/vagrant', type: 'rsync', rsync__exclude: '.git/'
      override.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
      override.vm.provision "file", source: "./bootstrap_files/chefdk_3.6.57-1_amd64.deb", destination: "$HOME/chefdk_3.6.57-1_amd64.deb"
    end
  end

  config.vm.define 'sonarqube-server' do |sonarqube|
    sonarqube.vm.provider "virtualbox" do |vm, override|
      override.vm.network 'private_network', ip: ips['sonarqube-server'] if ips
      override.vm.synced_folder '.', '/home/vagrant/sync', disabled: true
      override.vm.synced_folder '.', '/vagrant', type: 'rsync', rsync__exclude: '.git/'
      override.vm.network "forwarded_port", guest: 9000, host: 9090, auto_correct: true
      override.vm.provision "file", source: "./bootstrap_files/chefdk_3.6.57-1_amd64.deb", destination: "$HOME/chefdk_3.6.57-1_amd64.deb"
      sonarqube.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "3072"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
    end
  end
end
