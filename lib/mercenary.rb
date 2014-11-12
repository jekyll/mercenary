lib = File.expand_path('../', __FILE__)

require "#{lib}/mercenary/version"
require "optparse"
require "logger"

module Mercenary
  autoload :Command,   "#{lib}/mercenary/command"
  autoload :Option,    "#{lib}/mercenary/option"
  autoload :Presenter, "#{lib}/mercenary/presenter"
  autoload :Program,   "#{lib}/mercenary/program"

  # Public: Instantiate a new program and execute.
  #
  # name - the name of your program
  #
  # Returns nothing.
  def self.program(name)
    program = Program.new(name)
    yield program
    program.go(ARGV)
  end
end
