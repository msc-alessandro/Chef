require 'yaml'
require 'chake'
require 'erb'

begin
  load 'local.rake'
rescue LoadError
  # nothing
end

$CHAKE_ENV = ENV.fetch('CHAKE_ENV', 'local')

$CONVERGE_OPTS = {
  reinstall: ENV.fetch('REINSTALL', false)
}

config_file = "config/#{$CHAKE_ENV}/%s"
ssh_config_file = config_file % "ssh_config"
ips_file = config_file % "ips.yaml"

@USER = 'vagrant'

ENV['CHAKE_TMPDIR'] = "tmp/chake.#{$CHAKE_ENV}"
ENV['CHAKE_SSH_CONFIG'] = ssh_config_file

chake_rsync_options = ENV['CHAKE_RSYNC_OPTIONS'].to_s.clone
chake_rsync_options += ' --exclude backups'
chake_rsync_options += ' --exclude src'
ENV['CHAKE_RSYNC_OPTIONS'] = chake_rsync_options

if $CHAKE_ENV == 'lxc'
  system("mkdir -p config/lxc; sudo lxc-ls -f -F name,ipv4 | "\
         "sed -e '/^ese_chef/ !d; s/ese_chef_//; s/_[0-9_]*/:"\
         "/ ' > #{ips_file}.new; .yaml config/lxc/")
  begin
    ips = YAML.load_file("#{ips_file}.new")
    raise ArgumentError, "Error reading ips file" unless ips.is_a?(Hash)
    FileUtils.mv ips_file + '.new', ips_file
  rescue Exception => ex
    puts ex.message
    puts
    puts "Q: did you boot the containers first?"
    exit
  end
end

task :preconfig do
  command = "sudo apt-get install -y wget rsync"
  $nodes.each do |node|
    puts "###############################################"
    puts "[#{node.hostname}]: EXECUTING #{command}"
    puts "This can take long"
    puts "###############################################"

    output = IO.popen("ssh -F #{ssh_config_file} #{node.hostname} #{command}")
    output.each_line do |line|
      printf "%s: %s\n", node.hostname, line.strip
    end
    output.close
    if $?
      status = $?.exitstatus
      if status != 0
        raise Exception.new(['FAILED with exit status %d' % status].join(': '))
      end
    end
  end
end

task :test do
  sh "CHAKE_ENV=#{$CHAKE_ENV} ./test/run_all"
end


if ['local', 'lxc'].include?($CHAKE_ENV)
  @USER = 'vagrant'
end

ips ||= YAML.load_file(ips_file)

$nodes.each do |node|
  node.data['environment'] = $CHAKE_ENV
  node.data['peers'] = ips
  node.data['ip'] = ips[node.hostname]
  node.data['user'] = @USER
  node.data['options'] = $CONVERGE_OPTS
end

if ['local', 'lxc'].include?($CHAKE_ENV)
  template = %x( vagrant ssh-config )
  File.open(ssh_config_file, 'w') do |f|
    f.write(template)
  end
end

Dir.glob('tasks/*.rake').each { |f| load f }

