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
      command.options.map do |o|
        pretty_options = if o.size > 2
          o.take(2).join(", ")
        else
          o.first
        end
        "#{pretty_options.rjust(15)}  #{o.last}"
      end.join("\n")
    end

    def subcommands_presentation
      return nil unless command.commands.size > 0
      command.commands.map do |_, subcommand|
        "  #{subcommand.summarize}"
      end.join("\n")
    end

    def command_presentation
      msg = []
      msg << command.identity
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
        super # You *must* call super if you don't handle the
              # method, otherwise you'll
              # mess up Ruby's method lookup.
      end
    end
  end
end
