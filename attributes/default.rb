default['luigi']['user'] = 'luigi'
default['luigi']['group'] = 'luigi'
default['luigi']['config_dir'] = '/etc/luigi'

default['luigi_server']['auto_start'] = true
default['luigi_server']['log_dir'] = '/usr/local/var/log'
default['luigi_server']['pid_file'] = '/usr/local/var/luigid.pid'

default['client_cfg']['scheduler'] = {
  'record_task_history' = True, # Python syntaxe
  'state_path' = '/usr/local/var/luigi-state.pickle'
}

default['client_cfg']['task_history'] = {
  'db_connection' = 'sqlite:////usr/local/var/luigi-task-hist.db'
}
