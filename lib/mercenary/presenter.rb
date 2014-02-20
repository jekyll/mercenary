module Mercenary
  class Presenter
    attr_accessor :command

    def initialize(command)
      @command = command
    end

    def usage_presentation
      "  #{command.syntax}"
    end

    def options_presentation
      return nil unless command.options.size > 0
      command.options.map(&:to_s).join("\n")
    end

    def subcommands_presentation
      return nil unless command.commands.size > 0
      command.commands.values.map(&:summarize).join("\n")
    end

    def command_header
      header = "#{command.identity}"
      header << " -- #{command.description}" if command.description
      header
    end

    def command_presentation
      msg = []
      msg << command_header
      msg << "Usage:"
      msg << usage_presentation

      if opts = options_presentation
        msg << "Options:\n#{opts}"
      end
      if subcommands = subcommands_presentation
        msg << "Subcommands:\n#{subcommands_presentation}"
      end
      msg.join("\n\n")
    end

    def method_missing(meth, *args, &block)
      if meth.to_s =~ /^print_(.+)$/
        send("#{$1.downcase}_presentation")
      else
        super # You *must* call super if you don't handle the method,
              # otherwise you'll mess up Ruby's method lookup.
      end
    end
  end
end
