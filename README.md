# Ruby scripts with auto-installing dependencies

This repository shows how to write Ruby scripts that automatically install missing gems before they run, so no manual `bundle install` needed.

## How?

By using the `auto_install` setting introduced in Bundler 2.5.10, which lets `bundle exec` install missing dependencies on the fly.
To enable it project-wide (or globally), run `bundle config set [--global] auto_install true`.

The script should call `Bundler.require(*groups)` before the main logic.

```ruby
#!/usr/bin/env -S bundle exec ruby

# Change to the directory containing the Gemfile (assumed to be next to this script)
Dir.chdir(__dir__) do
  # Require gems via Bundler
  Bundler.require
end

# The rest of your script goes here...
```

You can also enable it on a per-script basis via the `BUNDLE_AUTO_INSTALL` environment variable.

```ruby
#!/usr/bin/env -S BUNDLE_AUTO_INSTALL=1 bundle exec ruby

Dir.chdir(__dir__) do
  Bundler.require
end

# ...
```

If you can't modify the shebang line or your `env` doesn't support `-S`, use this approach instead:

```ruby
#!/usr/bin/env ruby

require 'bundler'

# Must be set before calling Bundler.auto_install, otherwise it would do nothing
ENV['BUNDLE_AUTO_INSTALL'] = '1'

Dir.chdir(__dir__) do
  Bundler.auto_install
  Bundler.require
end

# ...
```

## Example output

Messages from Bundler will be printed to stdout if there are any missing gems to install.

```
% ./app.rb hello
Automatically installing missing gems.
Fetching gem metadata from https://rubygems.org/.
Fetching thor 1.5.0
Installing thor 1.5.0
Bundle complete! 1 Gemfile dependency, 1 gem now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Hello, World!

% ./app.rb hello
Hello, World!
```

## Bonus tip

You can auto-install Ruby itself with the [`rv`](https://github.com/spinel-coop/rv) version manager:

```ruby
#!/usr/bin/env -S rv run --ruby=4.0 bundle exec ruby

Dir.chdir(__dir__) do
  Bundler.require
end

# ...
```
