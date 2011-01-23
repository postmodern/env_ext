# Env

* [Homepage](http://github.com/postmodern/env)
* [Issues](http://github.com/postmodern/env/issues)
* [Documentation](http://rubydoc.info/gems/env)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

{Env} provides a Ruby interface to common environment variables, used on
both Linux, BSD, OSX and Windows.

## Features

* Provides access to:
  * `PATH`
  * `LANG`
  * `COLOMNS`
  * `EDITOR`
  * `HOME` (or `HOMEPATH` on Windows)
  * `LINES`
  * `SHELL`
  * `TERM` and `COLORTERM`

## Examples

    require 'env'

Transparently access environment variables like a Hash:

    Env['DESKTOP_SESSION']
    # => "gnome"

Transparently access environment variables like Constants:

    Env::DESKTOP_SESSION
    # => "gnome"

Transparently access environment variables like methods:

    Env.desktop_session
    # => "gnome"

Parse complex variables:

    Env.home
    # => "/home/hal"

    Env.paths
    # => ["/home/hal/.rvm/gems/ruby-1.9.2-p136/bin", "/home/hal/.rvm/gems/ruby-1.9.2-p136@global/bin", "/home/hal/.rvm/rubies/ruby-1.9.2-p136/bin", "/home/hal/.rvm/bin", "/usr/local/bin", "/usr/bin", "/bin", "/usr/local/sbin", "/usr/sbin", "/sbin", "/home/hal/bin", "/vault/0/src/rubinius/bin"]

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

Copyright (c) 2011 Hal Brodigan

See {file:LICENSE.txt} for details.
