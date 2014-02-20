module Mercenary
  class Option
    attr_reader :config_key, :description, :switches

    def initialize(config_key, info)
      @config_key = config_key
      @description = info.last unless info.last.start_with?("-")
      set_switches(info.take(info.size - [@description].reject(&:nil?).size))
    end

    def for_option_parser
      [switches.reject(&:empty?), description].reject{ |o| o.nil? || o.empty? }.flatten
    end

    def to_s
      "#{formatted_switches}  #{description}"
    end

    def formatted_switches
      [
        switches.first.rjust(10),
        switches.last.ljust(13)
      ].join(", ").gsub(/ , /, '   ').gsub(/,   /, '    ')
    end

    def hash
      instance_variables.map do |var|
        instance_variable_get(var).hash
      end.reduce(:&)
    end

    def eql?(other)
      return false unless self.class.eql?(other.class)
      instance_variables.each do |var|
        instance_variable_get(var).eql?(other.instance_variable_get(var))
      end
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
