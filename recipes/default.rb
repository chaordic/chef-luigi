#
# Cookbook Name:: luigi
# Recipe:: default
#

include_recipe 'python'

directory node['luigi']['dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
end

template "#{node['luigi']['dir']}/client.cfg" do
  source    'client.cfg.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  action    :create
  variables({
    :luigid_statefile => node['luigid']['file']['state']
    :luigi_sqlite => node['luigid']['sqlite']
  })
end

directory node['luigid']['dir'] do
  owner     node['luigid']['user']
  group     node['luigid']['group']
  mode      '0755'
  action    :create
end

directory node['luigid']['dir']['log'] do
  owner     node['luigid']['user']
  group     node['luigid']['group']
  mode      '0755'
  action    :create
end

directory node['luigid']['dir']['db'] do
  owner     node['luigid']['user']
  group     node['luigid']['group']
  mode      '0755'
  action    :create
end

service "luigid" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

template "etc/init.d/luigid" do
  source    'luigi-server.init.erb'
  owner     'root'
  group     'root'
  mode      '0755'
  action    :create
  notifies  :enable, 'service[luigid]'
  notifies  :start, 'service[luigid]'
  variables({
    :luigid_pidfile => node['luigid']['file']['pid']
    :luigid_logdir => node['luigid']['dir']['log']
  })
end

python_pip 'boto'
python_pip 'python-daemon'
python_pip 'SQLAlchemy'
python_pip 'luigi'
