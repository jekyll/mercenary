#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *%w{ .. lib })

require "mercenary"

# This example sets the logging mode of mercenary to
# debug. Logging messages from "p.logger.debug" will
# be output to STDOUT.

Mercenary.program(:help_dialogue) do |p|

  p.version "#.#.#"
  p.description 'An example of the help dialogue in Mercenary'
  p.syntax 'ruby help_dialogue.rb'

  p.command(:some_subcommand) do |c|
    c.version '1.4.2'
    c.syntax 'some_subcommand [options]'
    c.description 'Some subcommand to do something'
    c.option 'an_option', '-o', '--option', 'Some option'
  end

  p.command(:another_subcommand) do |c|
    c.syntax 'another_subcommand [options]'
    c.description 'Another subcommand to do something different.'
    c.option 'an_option', '-O', '--option', 'Some option'
    c.option 'another_options', '--pluginzzz', 'Set where the plugins should be found from'
  end

end
