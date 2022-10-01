# Yadisk - Yandex.Disk API client (ruby gem)

## Install

```sh
  gem install yadisk-client
```

## Development

```sh
  gem build yadisk.gemspec && gem install yadisk-client && bundle exec rake console
```

## Available methods

**Note**
`**params` not included in requests, but will be later
`**attributes` used in `update_meta` method only

```ruby

client = Yadisk::Client.new(api_key: 'paste your token here')

client.disk.info
client.disk.upload(src:, dest:)
client.disk.delete(path:)
client.disk.get_meta(path:, **params)

 # client.disk.update_meta(path: "dir_or_file_path", any_key_name: "value", other_key_name: "any_value")
client.disk.update_meta(path:, **attributes)
client.disk.create_dir(path:)
client.disk.copy(from:, to:, **params)
client.disk.download(path:, **params)
client.disk.list_files(**params)
client.disk.last_uploaded(**params)
client.disk.move(from:, to:, **params)
client.disk.list_public(**params)
client.disk.publish(path:, **params)
client.disk.unpublish(path:, **params)

client.public_resource.get_meta(public_key:, **params)
client.public_resource.get_link(public_key:, **params)
client.public_resource.save(public_key:, **params)

client.operation.status(operation_id:) - ok

client.trash.delete(**params)
client.trash.list(path:, **params)
client.trash.restore(path:, **params)
```

## TODOs

- tests
- examples
- readme
