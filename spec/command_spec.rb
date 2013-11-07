require "spec_helper"

describe(Mercenary::Command) do

  context "a basic command" do
    let(:command) { Mercenary::Command.new(:my_name) }
    let(:command_with_parent) do
      Mercenary::Command.new(
        :i_have_parent,
        parent
      )
    end
    let(:parent)  { Mercenary::Command.new(:my_parent) }
    let(:add_sub) do
      Proc.new do |c|
        c.command(:sub_command) { |p| }
      end
    end

    it "can be created with just a name" do
      expect(command.name).to eql(:my_name)
    end

    it "can hold a parent command" do
      expect(command_with_parent.parent).to eql(parent)
    end

    it "can create subcommands" do
      expect(add_sub.call(command)).to be_a(Mercenary::Command)
      expect(add_sub.call(command).parent).to eq(command)
    end

    it "can set its syntax" do
      syntax_string = "my_name [options]"
      cmd = described_class.new(:my_name)
      cmd.syntax syntax_string
      expect(cmd.syntax).to eq(syntax_string)
    end

    it "can set its description" do
      desc = "run all the things"
      command.description desc
      expect(command.description).to eq(desc)
    end

    it "can set its options" do
      name = "show_drafts"
      opt  = ['--drafts', 'Render posts in the _drafts folder']
      command.option name, *opt
      expect(command.options).to eq([opt])
      expect(command.map).to include({opt.first => name})
    end
  end

end
