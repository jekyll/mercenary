module Mercenary
  class Option
    attr_reader :config_key, :description, :switches

    # Public: Create a new Option
    #
    # config_key - the key in the config hash to which the value of this option will map
    # info       - an array containing first the switches, then a description of the option
    #
    # Returns nothing
    def initialize(config_key, info)
      @config_key = config_key
      @description = info.last unless info.last.start_with?("-")
      set_switches(info.take(info.size - [@description].reject(&:nil?).size))
    end

    # Public: Fetch the array containing the info OptionParser is interested in
    #
    # Returns the array which OptionParser#on wants
    def for_option_parser
      [switches.reject(&:empty?), description].reject{ |o| o.nil? || o.empty? }.flatten
    end

    # Public: Build a string representation of this option including the
    #   switches and description
    #
    # Returns a string representation of this option
    def to_s
      "#{formatted_switches}  #{description}"
    end

    # Public: Build a beautifully-formatted string representation of the switches
    #
    # Returns a formatted string representation of the switches
    def formatted_switches
      [
        switches.first.rjust(10),
        switches.last.ljust(13)
      ].join(", ").gsub(/ , /, '   ').gsub(/,   /, '    ')
    end

    # Public: Hash based on the hash value of instance variables
    #
    # Returns a Fixnum which is unique to this Option based on the instance variables
    def hash
      instance_variables.map do |var|
        instance_variable_get(var).hash
      end.reduce(:&)
    end

    # Public: Check equivalence of two Options based on equivalence of their
    #   instance variables
    #
    # Returns true if all the instance variables are equal, false otherwise
    def eql?(other)
      return false unless self.class.eql?(other.class)
      instance_variables.map do |var|
        instance_variable_get(var).eql?(other.instance_variable_get(var))
      end.all?
    end

    private

    # Private: Set the full switches array, ensuring the first element is the
    #   short switch and the second element is the long switch
    #
    # Returns the corrected switches array
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
