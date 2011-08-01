require 'env/variables'

module Env
  extend Variables

  #
  # Provides direct access to the environment variables.
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
    env[name.to_s]
  end

  #
  # Sets an environment variable.
  #
  # @param [String, Symbol] name
  #   The name of the environment variable.
  #
  # @param [Object] value
  #   The value of the environment variable.
  #
  # @return [String]
  #   The String value of the environment variable.
  #
  def Env.[]=(name,value)
    env[name.to_s] = value.to_s
  end

  protected

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
  # @example
  #   Env.shell = '/bin/zsh'
  #   # => "/bin/zsh"
  #
  def Env.method_missing(name,*arguments,&block)
    name = name.to_s

    if (arguments.length == 1 && name[-1..-1] == '=')
      name.chop!
      name.upcase!

      return Env[name] = arguments.first
    elsif arguments.empty?
      name.upcase!

      return Env[name]
    end

    super(name,*arguments,&block)
  end
end
