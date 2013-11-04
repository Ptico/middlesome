# Middlesome

- [![Build Status](https://travis-ci.org/Ptico/middlesome.png)](https://travis-ci.org/Ptico/middlesome)
- [![Code Climate](https://codeclimate.com/github/Ptico/middlesome.png)](https://codeclimate.com/github/Ptico/middlesome)


Standalone middleware manager

## Installation

Add this line to your application's Gemfile:

    gem 'middlesome'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middlesome

## Usage

```ruby
stack = Middlesome::Stack.new
stack.middlewares do
  use Rack::Logger
  use Rack::Cookies
end

stack.middlewares :development do
  use Rack::Debug, socket_path: '/tmp/rack-debug'
end

stack.middlewares :production do
  insert_before Rack::Logger, Rack::Auth::Basic, do |username, password|
    'secret' == password
  end

  delete_all Rack::Debug # Just in case
end

app = stack.build(Rack::Lobster.new, :production)
```

## Available manipulations

- `push(middleware, *args, &block)` alias `use(middleware, *args, &block)`
- `insert_before(one_middleware, another_middleware, *args, &block)`
- `insert_after(one_middleware, another_middleware, *args, &block)`
- `replace(one_middleware, with_middleware, *args, &block)`
- `delete(middleware)`
- `delete_all()`
- `delete_all(by_name)`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
