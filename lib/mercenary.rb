require "mercenary/version"
require "optparse"

module Mercenary
  autoload :Command, "mercenary/command"
  autoload :Program, "mercenary/program"

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
