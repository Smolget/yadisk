# Yadisk - API wrapper around Yandex.Disk (ruby)

Yadisk - это враппер написаный на Ruby для удобного сервиса Yandex.Disk

Позволяет: 
  - загружать файлы в облако Яндекса
  - скачивать файлы из облака
  - прочая магия для органзации работы с диском из приложений

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.

### Версия
1.0.2

### Установка

Глобально:

```sh
$ gem install yadisk
```

```sh
$ git clone https://github.com/wimnorder/ruby_yadisk.git
$ cd ruby_yadisk
$ nano config/config.rb
```

Для Rails будет так:

```Gemfile
   gem 'yadisk', '1.0.2', :git => 'https://github.com/wimnorder/ruby_yadisk.git'
```

### Инструкиця по использованию

```ruby
require 'yadisk'

yadisk = Yadisk.new(APP_ID, SECRET_KEY)
yadisk.send('file.zip', callback)

def callback
  p "Done successfully!"
end
```

### Совместная разработка

Хоти поучаствовать в разработке? Ок!

* Fork
* Commit
* Pull-request
* See ya changes!

### Todo:

 - Написать тесты (RSpec)
 - Сделать wiki-страницу на Github 
 - Рефакторить код
 - Снабдить примерами
 - Отрправить в рубигемс

Лицензия
----
MIT