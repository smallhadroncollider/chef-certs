## Attributes

DN components to use when creating certificate names:

- `node["certs"]["country"]`
- `node["certs"]["state"]`
- `node["certs"]["city"]`
- `node["certs"]["organization"]`
- `node["certs"]["department"]`
- `node["certs"]["email"]`

## Usage

Make sure you include the "certs" recipe:

```
include_recipe "certs"
```

Use the `certs_certificate` provider as follows:

```
certs_certificate "*.example.com" do
  action :create
  key "/etc/nginx/ssl/example.com.key"
  certificate "/etc/ssl/example.com.crt"
end
```

## Requirements

Installs the `openssl` package.

Tested on Ubuntu 14.04.


## Attribution
Based loosely on [cgravier/selfsigned_certificate](https://github.com/cgravier/selfsigned_certificate) and [VendaTech/chef-cookbook-ssl](https://github.com/VendaTech/chef-cookbook-ssl)

## Licence

**Author**: Mark Wales (<mark@smallhadroncollider.com>)

Copyright 2015 Small Hadron Collider 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
