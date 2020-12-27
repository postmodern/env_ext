# env_ext

* [Homepage](https://github.com/postmodern/env_ext)
* [Issues](https://github.com/postmodern/env_ext/issues)
* [Documentation](http://rubydoc.info/gems/env_ext/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

env_ext adds additional methods to `ENV` for common environment variables,
used on Linux, BSD, OSX and Windows.

## Methods

* {EnvExt::Methods#paths ENV.paths} -`PATH`
* {EnvExt::Methods#ld_library_paths ENV.ld_library_paths} - `LD_LIBRARY_PATH`
* {EnvExt::Methods#host_name ENV.host_name} -`HOMENAME`
* {EnvExt::Methods#user ENV.user} -`USER` or `LOGNAME`
* {EnvExt::Methods#home ENV.home} - `HOME`, `USERPROFILE`, or `HOMEPATH` and `HOMEDRIVE` on Windows.
* {EnvExt::Methods#lang ENV.lang} - `LANG`
* {EnvExt::Methods#timezone ENV.timezone} - `TZ`
* {EnvExt::Methods#shell ENV.shell} - `SHELL`
* {EnvExt::Methods#shell ENV.shell_name} - `SHELL`
* {EnvExt::Methods#columns ENV.columns} - `COLOMNS`
* {EnvExt::Methods#lines ENV.lines} - `LINES`
* {EnvExt::Methods#terminal ENV.terminal} - `TERM` or `COLORTERM`
* {EnvExt::Methods#editor ENV.editor} - `EDITOR`
* {EnvExt::Methods#browser ENV.browser} - `BROWSER`
* {EnvExt::Methods#debug? ENV.debug?} - `DEBUG`

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
