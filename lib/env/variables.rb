require 'pathname'

module Env
  module Variables
    #
    # The environment variables.
    #
    # @return [Hash{String => String}]
    #   The Hash of environment variable names and values.
    #
    def env_hash
      ENV
    end

    #
    # The directories to search within for executables.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def paths
      parse_paths(env_hash['PATH'])
    end

    #
    # The directories to search within for libraries.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def ld_library_paths
      parse_paths(env_hash['LD_LIBRARY_PATH'])
    end

    #
    # The home directory.
    #
    # @return [Pathname, nil]
    #   The path of the home directory.
    #
    def home
      # logic adapted from Gem.find_home.
      path = if (env_hash['HOME'] || env_hash['USERPROFILE'])
               env_hash['HOME'] || env_hash['USERPROFILE']
             elsif (env_hash['HOMEDRIVE'] && env_hash['HOMEPATH'])
               "#{env_hash['HOMEDRIVE']}#{env_hash['HOMEPATH']}"
             else
               begin
                 File.expand_path('~')
               rescue
                 if File::ALT_SEPARATOR
                   'C:/'
                 else
                   '/'
                 end
               end
             end

      return Pathname.new(path)
    end

    #
    # The default language.
    #
    # @return [Array<String, String>]
    #   The language name and encoding.
    #
    def lang
      if (lang = env_hash['LANG'])
        lang.split('.',2)
      else
        []
      end
    end

    #
    # The number of columns in the terminal.
    #
    # @return [Integer]
    #   The number of columns.
    #
    def columns
      env_hash['COLUMNS'].to_i if env_hash['COLUMNS']
    end

    #
    # The number of lines in the terminal.
    #
    # @return [Integer]
    #   The number of lines.
    #
    def lines
      env_hash['LINES'].to_i if env_hash['LINES']
    end

    #
    # The path of the default shell.
    #
    # @return [String, nil]
    #   The path to the default shell.
    #
    def shell
      env_hash['SHELL']
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
      env_hash['COLORTERM'] || env_hash['TERM']
    end

    #
    # The default editor to use.
    #
    # @return [String, nil]
    #   The name of the editor program.
    #
    def editor
      env_hash['EDITOR']
    end

    #
    # The default browser to use.
    #
    # @return [String, nil]
    #   The name of the browser program.
    #
    def browser
      env_hash['BROWSER']
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
