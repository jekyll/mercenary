# Mercenary

Lightweight and flexible library for writing command-line apps in Ruby.

[![Build Status](https://secure.travis-ci.org/jekyll/mercenary.png)](https://travis-ci.org/jekyll/mercenary)

## Installation

Add this line to your application's Gemfile:

    gem 'mercenary'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mercenary

**Note: Mercenary may not work with Ruby < 1.9.3.**

## Usage

Creating programs and commands with Mercenary is easy:

```ruby
Mercenary.program(:jekyll) do |p|
  p.version Jekyll::VERSION
  p.description 'Jekyll is a blog-aware, static site generator in Ruby'
  p.syntax "jekyll <subcommand> [options]"

  p.command(:new) do |c|
    c.syntax "new PATH" # do not include the program name or super commands
    c.description "Creates a new Jekyll site scaffold in PATH"
    c.option 'blank', '--blank', 'Initialize the new site without any content.'

    c.action do |args, options|
      Jekyll::Commands::New.process(args, blank: options['blank'])
    end
  end

  p.command(:build) do |c|
    c.syntax "build [options]"
    c.description "Builds your Jekyll site"

    c.option 'safe', '--safe', 'Run in safe mode'
    c.option 'source', '--source DIR', 'From where to collect the source files'
    c.option 'destination', '--dest DIR', 'To where the compiled files should be written'

    c.action do |_, options|
      Jekyll::Commands::Build.process(options)
    end
  end

  # Bring in command bundled in external gem
  begin
    require "jekyll-import"
    JekyllImport.init_with_program(p)
  rescue LoadError
  end

  p.default_command(:build)
end
```

All commands have the following default options:

- `-h/--help` - show a help message
- `-v/--version` - show the program version
- `-t/--trace` - show the full backtrace when an error occurs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
