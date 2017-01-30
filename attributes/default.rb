# AWS keys
info = Chef::EncryptedDataBagItem.load('aws', 's3')
default['aws']['access_key_id'] = info['keys']['access_key']
default['aws']['secret_access_key'] = info['keys']['secret_key']

default['luigi']['user'] = 'luigi'
default['luigi']['group'] = 'luigi'
default['luigi']['dir'] = '/etc/luigi'

default['luigid']['user'] = 'luigi'
default['luigid']['group'] = 'luigi'
default['luigid']['dir'] = '/mnt/luigid'
default['luigid']['dir']['db'] = '/mnt/luigid/db'
default['luigid']['dir']['log'] = '/mnt/luigid/log'
default['luigid']['file']['state'] = '/mnt/luigid/luigid.pid'
default['luigid']['file']['pid'] = '/mnt/luigid/luigi-state.pickle'
default['luigid']['sqlite'] = '/mnt/luigid/db/luigi-task-hist.db'
