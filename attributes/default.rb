default['luigi']['setup_user'] = true
default['luigi']['setup_group'] = true
default['luigi']['user'] = 'luigi'
default['luigi']['group'] = 'luigi'
default['luigi']['config_dir'] = '/etc/luigi'

default['luigi']['server']['auto_start'] = true
default['luigi']['server']['log_dir'] = '/var/log/luigi'
default['luigi']['server']['pid_file'] = '/var/run/luigid.pid'


default['luigi']['client_cfg'] = {
  'scheduler' => {
    'record_task_history' => true,
    'state_path' => '/usr/local/var/luigi-state.pickle'
  },
  'task_history' => {
    'db_connection' => 'sqlite:////usr/local/var/luigi-task-hist.db'
  }
}
