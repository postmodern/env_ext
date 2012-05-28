# Env

* [Homepage](https://github.com/postmodern/env)
* [Issues](https://github.com/postmodern/env/issues)
* [Documentation](http://rubydoc.info/gems/env/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

{Env} provides a Ruby interface to common environment variables, used on
Linux, BSD, OSX and Windows.

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

    require 'env'

Transparently access environment variables as a Hash:

    Env['DESKTOP_SESSION']
    # => "gnome"

Transparently access environment variables as Constants:

    Env::DESKTOP_SESSION
    # => "gnome"

Transparently access environment variables with methods:

    Env.desktop_session
    # => "gnome"

Parse complex variables:

    Env.home
    # => #<Pathname:/home/alice>

    Env.paths
    # => [#<Pathname:/usr/local/bin>, #<Pathname:/usr/bin>, #<Pathname:/bin>, #<Pathname:/usr/local/sbin>, #<Pathname:/usr/sbin>, #<Pathname:/sbin>]

    Env.lang
    # => ["en_US", "utf8"]

    Env.terminal
    # => "gnome-terminal"

    Env.shell
    # => "/bin/bash"

    Env.editor
    # => "vim"

Only access the common variables from your Class:

    class Project

      include Env::Variables

    end

## Install

    $ gem install env

## Copyright

Copyright (c) 2011-2012 Hal Brodigan

See {file:LICENSE.txt} for details.
