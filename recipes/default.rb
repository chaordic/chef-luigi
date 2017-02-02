#
# Cookbook Name:: luigi
# Recipe:: default
#

include_recipe 'python'

directory node['luigi']['config_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
end

template "#{node['luigi']['config_dir'}/client.cfg" do
  source    'client.cfg.erb'
  owner     node['luigi']['user'] || 'root'
  group     node['luigi']['group'] || 'root'
  mode      '0755'
  action    :create
  variables({
    :client_cfg => node['client_cfg']
  })
end

directory node['luigi_server']['log_dir'] do
  owner     node['luigi']['user'] || 'root'
  group     node['luigi']['group'] || 'root'
  mode      '0755'
  action    :create
end

template '/etc/default/luigid' do
  source    'client.cfg.erb'
  owner     node['luigi']['user'] || 'root'
  group     node['luigi']['group'] || 'root'
  mode      '0755'
  action    :create
  variables({
    :env => node['luigi']['env']
  })
end

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
  owner     node['luigi']['user'] || 'root'
  group     node['luigi']['group'] || 'root'
  mode      '0755'
  action    :create
  notifies  :enable, 'service[luigid]'
  notifies  :start, 'service[luigid]' if node['luigid']['auto_start']
  variables({
    :luigid_pidfile => node['luigi_server']['pid_file']
    :luigid_logdir => node['luigi_server']['log_dir']
  })
end
