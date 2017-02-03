#
# Cookbook Name:: luigi
# Recipe:: default
#
user node['luigi']['user'] do
  system  true
  shell   "/bin/false"
  only_if node['luigi']['setup_user']
end

group node['luigi']['group'] do
  system  true
  only_if node['luigi']['setup_group']
end

directory node['luigi']['config_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
end

template "#{node['luigi']['config_dir'}/client.cfg" do
  source    'client.cfg.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  recursive true
  action    :create
  variables({
    :client_cfg => node['client_cfg']
  })
end

directory node['luigi_server']['log_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
end

template '/etc/default/luigid' do
  source    'client.cfg.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
  variables({
    :env => node['luigi']['env']
  })
end

include_recipe 'python'

python_pip 'boto'
python_pip 'python-daemon'
python_pip 'SQLAlchemy'
python_pip 'luigi'

service 'luigid' do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

template "etc/init.d/luigid" do
  source    'luigi-server.init.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
  notifies  :enable, 'service[luigid]'
  notifies  :start, 'service[luigid]' if node['luigi']['server']['auto_start']
  variables({
    :luigid_pidfile => node['luigi']['server']['pid_file']
    :luigid_logdir => node['luigi']['server']['log_dir']
  })
end
