# Yadisk - Yandex.Disk API client (ruby gem)

[![Gem Version](https://badge.fury.io/rb/yadisk-client.svg)](https://badge.fury.io/rb/yadisk-client)
![Gem](https://img.shields.io/gem/dt/yadisk-client)
[![Ruby specs](https://github.com/Smolget/yadisk/actions/workflows/CI.yml/badge.svg)](https://github.com/Smolget/yadisk/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/Smolget/yadisk-client/badge.svg?branch=master)](https://coveralls.io/github/Smolget/yadisk-client?branch=master)

## Install

```sh
  gem install yadisk-client
```

## Development

```sh
  gem build yadisk.gemspec && gem install yadisk-client && bundle exec rake console
```

## Available methods

> **Note**
> `**params` not included in requests, but will be later  
> `**attributes` used in `update_meta` method only

```ruby

client = Yadisk::Client.new(token: 'paste your token here')

client.disk.info
client.disk.upload(path:)
client.disk.upload_from_file(upload_link:, src:)
client.disk.upload_by_url(path:, url:)
client.disk.delete(path:)
client.disk.get_meta(path:, **params)

 # client.disk.update_meta(path: "dir_or_file_path", any_key_name: "value", other_key_name: "any_value")
client.disk.update_meta(path:, **attributes)
client.disk.create_dir(path:)
client.disk.copy(from:, to:)
client.disk.download(path:, **params)
client.disk.list_files(**params)
client.disk.last_uploaded(**params)
client.disk.move(from:, to:)
client.disk.list_public(**params)
client.disk.publish(path:)
client.disk.unpublish(path:)

client.public_resource.meta(public_key:, **params)
client.public_resource.link(public_key:, **params)
client.public_resource.save(public_key:, **params)

client.operation.status(operation_id:)

client.trash.delete(path:, **params)
client.trash.list(path:, **params)
client.trash.restore(path:)
```

## TODOs

- ~~tests~~
- examples
- ~~readme~~
