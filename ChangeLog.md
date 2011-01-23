### 0.1.1 / 2011-01-23

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

