module Mercenary
  class Option
    attr_reader :config_key, :description, :switches

    def initialize(config_key, info)
      @config_key = config_key
      @description = info.last
      set_switches(info.take(info.size - 1))
    end

    def for_option_parser
      [switches.reject(&:empty?), description].flatten
    end

    def to_s
      "#{formatted_switches}  #{description}"
    end

    def formatted_switches
      [
        switches.first.rjust(12),
        switches.last.ljust(15)
      ].join(", ").gsub(/ , /, '   ')
    end

    private
    def set_switches(switches)
      if switches.size < 2
        if switches.first.start_with?("--")
          switches.unshift ""
        else
          switches << ""
        end
      end
      @switches = switches
    end

  end
end
