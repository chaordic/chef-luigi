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

Optional attributes:
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['aws']['access_key_id']</tt></td>
    <td>String</td>
    <td>AWS Access key ID</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['aws']['secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS Secret access key</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Please check [attributes/default.rb](attributes/default.rb)  for the entire list of attributes.

Usage
-----
#### luigi::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `luigi` in your node's `run_list`:

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
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
