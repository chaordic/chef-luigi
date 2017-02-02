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
    <td><tt>['luigi']['dir']</tt></td>
    <td>String</td>
    <td>Directory for luigi configuration</td>
    <td><tt>'/etc/luigi'</tt></td>
  </tr>
  <tr>
    <td><tt>['luigid']['dir']</tt></td>
    <td>String</td>
    <td>Directory for luigid</td>
    <td><tt>'/mnt/luigid'</tt></td>
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
default['client_cfg']['mysection'] = {
  'option' = 'hello',
  'intoption' = 123
}
```

In order to load ENV variables when running your service, you can add them as:
```
default['luigi']['env']['VARIABLE'] = 'value'
```


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
