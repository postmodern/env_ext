# env_ext

* [Homepage](https://github.com/postmodern/env_ext)
* [Issues](https://github.com/postmodern/env_ext/issues)
* [Documentation](http://rubydoc.info/gems/env_ext/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

env_ext adds additional methods to `ENV` for common environment variables,
used on Linux, BSD, OSX and Windows.

## Features

* Provides access to:
  * `HOME` (or `HOMEPATH` on Windows)
  * `PATH`
  * `LD_LIBRARY_PATH`
  * `SHELL`
  * `TERM` and `COLORTERM`
  * `COLOMNS`
  * `LINES`
  * `EDITOR`
  * `BROWSER`
  * `LANG`
  * `TZ`
  * `DEBUG`

## Examples

    require 'env_ext'

Parse complex variables:

    ENV.home
    # => #<Pathname:/home/alice>

    ENV.paths
    # => [#<Pathname:/usr/local/bin>, #<Pathname:/usr/bin>, #<Pathname:/bin>, #<Pathname:/usr/local/sbin>, #<Pathname:/usr/sbin>, #<Pathname:/sbin>]

    ENV.lang
    # => ["en_US", "utf8"]

    ENV.terminal
    # => "gnome-terminal"

    ENV.shell
    # => "/bin/bash"

    ENV.editor
    # => "vim"

Extend your own `ENV` hash:

    MyENV.extend EnvExt::Methods

## Install

    $ gem install env_ext

## Copyright

Copyright (c) 2011-2020 Hal Brodigan

See {file:LICENSE.txt} for details.
