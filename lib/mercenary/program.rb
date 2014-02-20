module Mercenary
  class Program < Command
    attr_reader :optparse
    attr_reader :config

    # Public: Creates a new Program
    #
    # name - the name of the program
    #
    # Returns nothing
    def initialize(name)
      @config = {}
      super(name)
    end

    # Public: Run the program
    #
    # argv - an array of string args (usually ARGV)
    #
    # Returns nothing
    def go(argv)
      logger.debug("Using args passed in: #{argv.inspect}")

      cmd = nil

      @optparse = OptionParser.new do |opts|
        cmd = super(argv, opts, @config)
      end

      @optparse.parse!(argv)

      logger.debug("Parsed config: #{@config.inspect}")

      cmd.execute(argv, @config)
    end
  end
end
