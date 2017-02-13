#
# Cookbook Name:: luigi
# Recipe:: default
#
group node['luigi']['group'] do
  system    true
  only_if   { node['luigi']['setup_group'] }
end

user node['luigi']['user'] do
  system    true
  shell     '/bin/false'
  gid       node['luigi']['group']
  only_if   { node['luigi']['setup_user'] }
end

directory node['luigi']['config_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  recursive true
  action    :create
end

template "#{node['luigi']['config_dir']}/client.cfg" do
  source    'client.cfg.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0644'
  action    :create
  variables({
    :client_cfg => node['luigi']['client_cfg']
  })
end

directory node['luigi']['server']['log_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  recursive true
  action    :create
end

if node['luigi']['server']['dir']
  directory node['luigi']['server']['dir'] do
    owner     node['luigi']['user']
    group     node['luigi']['group']
    mode      '0755'
    recursive true
    action    :create
  end
end


template '/etc/default/luigid' do
  source    'luigi-env.sh.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0644'
  action    :create
  variables({
    :env => node['luigi']['server']['env']
  })
end

include_recipe 'python'

python_pip 'boto'
python_pip 'python-daemon'
python_pip 'SQLAlchemy'

if node['luigi']['version']
  python_pip 'luigi' do
    version node['luigi']['version']
    :upgrade
  end
else
    python_pip 'luigi'
end

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
    :luigid_pidfile => node['luigi']['server']['pid_file'],
    :luigid_logdir => node['luigi']['server']['log_dir']
  })
end
