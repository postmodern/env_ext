require 'pathname'

module Env
  module Variables
    #
    # The directories to search within for executables.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def paths
      parse_paths(ENV['PATH'])
    end

    #
    # The directories to search within for libraries.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def ld_library_paths
      parse_paths(ENV['LD_LIBRARY_PATH'])
    end

    #
    # The home directory.
    #
    # @return [Pathname, nil]
    #   The path of the home directory.
    #
    def home
      if (home = (ENV['HOME'] || ENV['HOMEPATH']))
        Pathname.new(home)
      end
    end

    #
    # The default language.
    #
    # @return [Array<String, String>]
    #   The language name and encoding.
    #
    def lang
      ENV['LANG'].split('.',2)
    end

    #
    # The number of columns in the terminal.
    #
    # @return [Integer]
    #   The number of columns.
    #
    def columns
      ENV['COLUMNS'].to_i if ENV['COLUMNS']
    end

    #
    # The number of lines in the terminal.
    #
    # @return [Integer]
    #   The number of lines.
    #
    def lines
      ENV['LINES'].to_i if ENV['LINES']
    end

    #
    # The path of the default shell.
    #
    # @return [String, nil]
    #   The path to the default shell.
    #
    def shell
      ENV['SHELL']
    end

    #
    # The name of the default shell.
    #
    # @return [String, nil]
    #   The program name of the shell.
    #
    def shell_name
      File.basename(shell) if shell
    end

    #
    # The default terminal to use.
    #
    # @return [String, nil]
    #   The name of the terminal program.
    #
    def terminal
      ENV['COLORTERM'] || ENV['TERM']
    end

    #
    # The default editor to use.
    #
    # @return [String, nil]
    #   The name of the editor program.
    #
    def editor
      ENV['EDITOR']
    end

    #
    # The default browser to use.
    #
    # @return [String, nil]
    #   The name of the browser program.
    #
    def browser
      ENV['BROWSER']
    end

    protected

    #
    # Parses a String containing multiple paths.
    #
    # @return [Array<Pathname>]
    #   The multiple paths.
    #
    def parse_paths(paths)
      if paths
        paths.split(File::PATH_SEPARATOR).map do |path|
          Pathname.new(path)
        end
      else
        []
      end
    end
  end
end
