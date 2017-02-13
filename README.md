luigi Cookbook
==============

This cookbook installs and configures [luigi](https://github.com/spotify/luigi).

Requirements
------------
#### Cookbooks
- `python` - luigi needs python cookbook to run.

Attributes
----------
#### luigi::default

The main attributes are:
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['luigi']['version']</tt></td>
    <td>String</td>
    <td>luigi version to be installed</td>
    <td><tt>'2.5.0'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['config_dir']</tt></td>
    <td>String</td>
    <td>Directory for luigi configuration</td>
    <td><tt>'/etc/luigi'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['setup_user']</tt></td>
    <td>Boolean</td>
    <td>If true it will create a luigi Unix user</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['user']</tt></td>
    <td>String</td>
    <td>Unix user name</td>
    <td><tt>'luigi'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['setup_group']</tt></td>
    <td>Boolean</td>
    <td>If true it will create a luigi Unix group</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['group']</tt></td>
    <td>String</td>
    <td>Unix group name</td>
    <td><tt>'luigi'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['server']['auto_start']</tt></td>
    <td>Boolean</td>
    <td>If true the luigid service will auto start</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['server']['log_dir']</tt></td>
    <td>String</td>
    <td>The luigid log directory</td>
    <td><tt>'/var/log/luigi'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigi']['server']['pid_file']</tt></td>
    <td>String</td>
    <td>The luigid pid file</td>
    <td><tt>'/var/run/luigid.pid'</tt></td>
  </tr>
</table>

All the [configuration of luigi](http://luigi.readthedocs.io/en/stable/configuration.html#scheduler-config) are written to `default['luigi']['config_dir']/client.cfg` file. The pattern is:
```
[mysection]
option=hello
intoption=123
```

and you can add them through chef as follows:

```
default['luigi']['client_cfg'] = {
  mysection => {
    'option' = 'hello',
    'intoption' = 123
  }
}
```

In order to load ENV variables when running your service, you can add them as:
```
default['luigi']['server']['env']['VARIABLE'] = 'value'
```

In order to create a default luigid directory you can add:
```
default['luigi']['server']['dir'] = '/var/luigi'
```
If present, it will create this directory and it's present by default.

Please check [attributes/default.rb](attributes/default.rb)  for the entire list of attributes.

Usage
-----
#### luigi::default
In order to install luigi, add this in you machine configuration recipe:
```
include_recipe 'luigi'
```

Or just include `luigi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[luigi]"
  ]
}
```

Contributing
------------

Feel free to fork this repository and use it the way you like. If you want to propose any improvements, just create a pull request from you forked branch.

License and Authors
-------------------
The full list of contributors is [here](https://github.com/chaordic/chef-luigi/graphs/contributors).

[MIT](LICENSE.md) © [Chaordic](http://chaordic.com.br/)
