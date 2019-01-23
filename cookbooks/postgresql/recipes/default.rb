postgresql_client_install 'PostgreSQL Client' do
  version '9.6'
end
postgresql_server_install 'PostgreSQL Server install' do
    action :install
end

postgresql_server_install 'Setup PostgreSQL Server' do
  version '9.6'
  password 'ed2017*789'
  action :create
end

postgresql_server_conf 'PostgreSQL Config' do
  version '9.6'
  notifies :reload, 'service[postgresql]'
end

service 'postgresql' do
  action :reload
end

postgresql_user 'sonar' do
  login true
  password 'sonar'
  host 'localhost'
  createdb true
  createrole true
  superuser true
end

postgresql_database 'sonar_db' do
  owner 'sonar'
end

postgresql_access 'local_sonar_user' do
  comment 'Sonar user access'
  access_type 'host'
  access_db 'all'
  access_user 'sonar'
  access_addr 'localhost'
  access_method 'md5'
end

