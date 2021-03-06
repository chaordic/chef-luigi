#
# Cookbook Name:: luigi
# Recipe:: default
#
if node['luigi']['setup_group']
  group node['luigi']['group'] do
    system    true
  end
end

if node['luigi']['setup_user']
  user node['luigi']['user'] do
    system    true
    shell     node['luigi']['shell']
    gid       node['luigi']['group']
  end
end

directory node['luigi']['config_dir'] do
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0755'
  recursive true
  action    :create
end

template "#{node['luigi']['config_dir']}/luigi.cfg" do
  source    'luigi.cfg.erb'
  owner     node['luigi']['user']
  group     node['luigi']['group']
  mode      '0644'
  action    :create
  variables({
    :luigi_cfg => node['luigi']['luigi_cfg']
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

python_pip 'luigi' do
  version node['luigi']['version']
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
