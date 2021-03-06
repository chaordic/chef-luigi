default['luigi']['version'] = '2.5.0'

default['luigi']['setup_user'] = true
default['luigi']['setup_group'] = true
default['luigi']['user'] = 'luigi'
default['luigi']['group'] = 'luigi'
default['luigi']['shell'] = '/bin/false'

default['luigi']['config_dir'] = '/etc/luigi'

default['luigi']['server']['auto_start'] = true
default['luigi']['server']['log_dir'] = '/var/log/luigi'
default['luigi']['server']['pid_file'] = '/var/run/luigid.pid'

default['luigi']['server']['dir'] = '/var/luigi'

default['luigi']['luigi_cfg'] = {
  'scheduler' => {
    'record_task_history' => true,
    'state_path' => '/var/luigi/luigi-state.pickle'
  },
  'task_history' => {
    'db_connection' => 'sqlite:////var/luigi/luigi-task-hist.db'
  }
}
