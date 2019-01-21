postgresql_client_install 'PostgreSQL Client' do
  setup_repo false
  version '10.6'
end

postgresql_server_install 'PostgreSQL Server' do
  version '10.6'
  setup_repo false
  password 'ed2017*789'
end

postgresql_server_conf 'PostgreSQL Config' do
  notifies :reload, 'service[postgresql]'
end

postgresql_user 'sonar' do
  password 'sonar'
  createdb true
end

postgresql_database 'sonar_db' do
  owner 'sonar'
end
