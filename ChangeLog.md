### 0.3.0 / 2012-05-27

* Added {Env::Variables#user}.
* Added {Env::Variables#host_name}.
* Fixed typos {Env.[]} and {Env.[]=} where the old `env_hash` method
  was being called.
* Fixed specs that were stubbing the old `env_hash` method.
* Replaced ore-tasks with
  [rubygems-tasks](https://github.com/postmodern/rubygems-tasks#readme).

### 0.2.0 / 2011-05-05

* Added {Env::Variables#timezone}.
* Added {Env::Variables#debug?}.
* Opt into [test.rubygems.org](http://test.rubygems.org/).

### 0.1.2 / 2011-01-23

* Fixed {Env::Variables#home} to match the behavior of `Gem.find_home`.
* Have {Env::Variables#lang} return an empty Array if the `LANG`
  environment variable is not set.

### 0.1.0 / 2011-01-22

* Initial release:
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
  * Added {Env}.
  * Added {Env::Variables}.

