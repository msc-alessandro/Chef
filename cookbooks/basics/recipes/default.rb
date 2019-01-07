PLATFORM = node[:platform]

package 'openssh-server'
package 'vim'
package 'make'
package 'tar'
package 'ca-certificates'
package 'curl'
package 'ntp'
package 'firewalld'
package 'net-tools'



package 'install epel release' do
  case PLATFORM
  when 'redhat', 'centos'
    package_name 'epel-release'
    action :install
  when 'ubuntu', 'debian'
    action :nothing
  end
end

package 'install open ssh client' do
  case PLATFORM
  when 'redhat', 'centos'
    package_name 'openssh-clients'
    action :install
  when 'ubuntu', 'debian'
    package_name 'openssh-client'
    action :install
  end
end

cookbook_file '/usr/local/bin/is-a-container' do
  owner 'root'
  group 'root'
  mode 0755
end

service 'ntp' do
  action [:enable, :start]
  not_if 'is-a-container'
end

template '/etc/hosts' do
  owner 'root'
  group 'root'
  mode 0755
end

