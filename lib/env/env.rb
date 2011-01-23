require 'env/variables'

module Env
  extend Variables

  #
  # Provides transparent access to the environment variables.
  #
  # @param [String, Symbol] name
  #   The name of the environment variable.
  #
  # @return [String, nil]
  #   The value of the environment variable.
  #
  # @example
  #   Env['SHELL']
  #   # => "/bin/bash"
  #
  def Env.[](name)
    ENV[name.to_s]
  end

  #
  # Provides transparent access to the environment variables.
  #
  # @param [Symbol] name
  #   The name of the environment variable.
  #
  # @return [String, nil]
  #   The value of the environment variable.
  #
  # @example
  #   Env::SHELL
  #   # => "/bin/bash"
  #
  def Env.const_missing(name)
    Env[name.to_s]
  end

  #
  # Provides transparent access to the environment variables.
  #
  # @param [Symbol] name
  #   The name of the environment variable.
  #
  # @return [String, nil]
  #   The value of the environment variable.
  #
  # @example
  #   Env.shell
  #   # => "/bin/bash"
  #
  def Env.method_missing(name,*arguments,&block)
    if arguments.empty?
      name = name.to_s
      name.upcase!

      return Env[name]
    end

    super(name,*arguments,&block)
  end
end
