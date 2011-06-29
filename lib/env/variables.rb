require 'pathname'

module Env
  module Variables
    #
    # The environment variables.
    #
    # @return [Hash{String => String}]
    #   The Hash of environment variable names and values.
    #
    # @api semipublic
    #
    def env
      ENV
    end

    #
    # The directories to search within for executables.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def paths
      parse_paths(env['PATH'])
    end

    #
    # The directories to search within for libraries.
    #
    # @return [Array<Pathname>]
    #   The paths of the directories.
    #
    def ld_library_paths
      parse_paths(env['LD_LIBRARY_PATH'])
    end

    #
    # The host-name of the system.
    #
    # @return [String]
    #   The host-name.
    #
    # @since 0.3.0
    #
    def host_name
      env['HOSTNAME']
    end

    #
    # The name of the current user.
    #
    # @return [String]
    #   The name of the user.
    #
    # @since 0.3.0
    #
    def user
      # USER is used on GNU/Linux and Windows
      # LOGNAME is the POSIX user-name ENV variable
      env['USER'] || env['LOGNAME']
    end

    #
    # The home directory.
    #
    # @return [Pathname]
    #   The path of the home directory.
    #
    def home
      # logic adapted from Gem.find_home.
      path = if (env['HOME'] || env['USERPROFILE'])
               env['HOME'] || env['USERPROFILE']
             elsif (env['HOMEDRIVE'] && env['HOMEPATH'])
               "#{env['HOMEDRIVE']}#{env['HOMEPATH']}"
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
      if (lang = env['LANG'])
        lang.split('.',2)
      else
        []
      end
    end

    #
    # The default timezone.
    #
    # @return [String, nil]
    #   The timezone name.
    #
    # @since 0.2.0
    #
    def timezone
      env['TZ']
    end

    #
    # The number of columns in the terminal.
    #
    # @return [Integer]
    #   The number of columns.
    #
    def columns
      env['COLUMNS'].to_i if env['COLUMNS']
    end

    #
    # The number of lines in the terminal.
    #
    # @return [Integer]
    #   The number of lines.
    #
    def lines
      env['LINES'].to_i if env['LINES']
    end

    #
    # The path of the default shell.
    #
    # @return [String, nil]
    #   The path to the default shell.
    #
    def shell
      env['SHELL']
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
      env['COLORTERM'] || env['TERM']
    end

    #
    # The default editor to use.
    #
    # @return [String, nil]
    #   The name of the editor program.
    #
    def editor
      env['EDITOR']
    end

    #
    # The default browser to use.
    #
    # @return [String, nil]
    #   The name of the browser program.
    #
    def browser
      env['BROWSER']
    end

    #
    # Determines whether optional Debugging was enabled.
    #
    # @return [Boolean]
    #   Specifies whether the `DEBUG` variable was specified.
    #
    # @since 0.2.0
    #
    def debug?
      true if env['DEBUG']
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
