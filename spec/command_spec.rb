require 'spec_helper'

describe RPlusPlus::Command do
  let(:fake_command) { spy('command') }
  after do
    RPlusPlus::Command.commands.clear
  end

  describe '#register' do
    it 'registers a command' do
      RPlusPlus::Command::register :command, fake_command

      expect(RPlusPlus::Command.commands).to include(:command => fake_command)
    end
  end

  describe '#call' do
    before do
      RPlusPlus::Command.register :command, fake_command
    end
    
    it 'calls the specific command with the given arguments' do
      RPlusPlus::Command.call :command, :something, option: 'foobar'

      expect(fake_command).to have_received(:call).with(:something, option: 'foobar')
    end
  end
end
