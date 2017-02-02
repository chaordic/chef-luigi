default['luigi']['user'] = 'luigi'
default['luigi']['group'] = 'luigi'
default['luigi']['dir'] = '/etc/luigi'

default['luigid']['user'] = 'luigi'
default['luigid']['group'] = 'luigi'
default['luigid']['auto_start'] = True
default['luigid']['dir'] = '/mnt/luigid'
default['luigid']['dir']['db'] = '/mnt/luigid/db'
default['luigid']['dir']['log'] = '/mnt/luigid/log'
default['luigid']['file']['pid'] = '/mnt/luigid/luigid.pid'
default['luigid']['file']['state'] = '/mnt/luigid/luigi-state.pickle'
default['luigid']['sqlite'] = '/mnt/luigid/db/luigi-task-hist.db'

default['client_cfg']['scheduler'] = {
  'record_task_history' = True,
  'state_path' = default['luigid']['file']['state']
}

default['client_cfg']['task_history'] = {
  'db_connection' = "sqlite:///#{default['luigid']['sqlite']}"
}
