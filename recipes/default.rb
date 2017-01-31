#
# Cookbook Name:: luigi
# Recipe:: default
#

include_recipe 'python'

directory node['luigi']['dir'] do
  owner   node['luigi']['user']
  group   node['luigi']['group']
  mode    '0755'
  action  :create
end

template "#{node['luigi']['dir']}/client.cfg" do
  source  'client.cfg.erb'
  owner   node['luigi']['user']
  group   node['luigi']['group']
  mode    '0755'
  action  :create
  variables({
    :aws_access_key_id => node['aws']['s3-access-key'],
    :aws_secret_access_key => node['aws']['s3-secret-key']
    :luigid_statefile => node['luigid']['file']['state']
    :luigi_sqlite => node['luigid']['sqlite']
  })
end

directory node['luigid']['dir'] do
  owner   node['luigid']['user']
  group   node['luigid']['group']
  mode    '0755'
  action  :create
end

directory node['luigid']['dir']['log'] do
  owner   node['luigid']['user']
  group   node['luigid']['group']
  mode    '0755'
  action  :create
end

directory node['luigid']['dir']['db'] do
  owner   node['luigid']['user']
  group   node['luigid']['group']
  mode    '0755'
  action  :create
end

python_pip 'boto'
python_pip 'python-daemon'
python_pip 'SQLAlchemy'
python_pip 'luigi'
