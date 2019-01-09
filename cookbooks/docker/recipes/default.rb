PLATFORM = node[:platform]

case PLATFORM
  when 'redhat', 'centos'

    execute 'Update centos nodes' do
      command 'yum check-update'
      user 'root'
    end

    execute 'Download and install Docker' do
      command 'curl -fsSL https://get.docker.com/ | sh'
      user 'root'
    end

  when 'ubuntu', 'debian'

    package 'apt-transport-https'
    package 'ca-certificates'
    package 'curl'
    package 'gnupg2'
    package 'software-properties-common'


    execute 'Download docker respository' do
      command 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -'
      user 'root'
    end

    execute 'Add docker repository do debian sources' do
      command 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"'
      user 'root'
    end

    apt_update

    package 'docker-ce'

  when 'windows'

  else
    # Do nothing
end

service 'docker' do
  action [:enable, :start]
end
