require 'spec_helper'

describe RPlusPlus::Command do
  let(:fake_command) { spy('command') }
  after do
    RPlusPlus::Command.commands.delete :test_command
  end

  describe '#register' do
    it 'registers a command' do
      RPlusPlus::Command::register :test_command, fake_command

      expect(RPlusPlus::Command.commands).to include(:test_command => fake_command)
    end
  end

  describe '#list' do
    after do
      [:foo, :bar, :baz].each { |x| RPlusPlus::Command.commands.delete x }
    end

    it 'lists all registered generators' do
      RPlusPlus::Command.register(:foo, fake_command)
      RPlusPlus::Command.register(:bar, fake_command)
      RPlusPlus::Command.register(:baz, fake_command)

      expect(RPlusPlus::Command.list).to include(:foo, :bar, :baz)
    end
  end

  describe '#call' do
    before do
      RPlusPlus::Command.register :test_command, fake_command
    end

    it 'calls the specific command with the given arguments' do
      RPlusPlus::Command.call :test_command, 'foo', 'bar', 'baz'

      expect(fake_command).to have_received(:call).with('foo', 'bar', 'baz')
    end

    it 'converts command strings to symbols' do
      RPlusPlus::Command.call 'test_command', 'foo', 'bar', 'baz'

      expect(fake_command).to have_received(:call).with('foo', 'bar', 'baz')
    end

    it 'raises if the specific command does not exists' do
      expect {
        RPlusPlus::Command.call :nonexistent, :something
      }.to raise_error(RPlusPlus::Command::MissingCommandError,
        "'nonexistent' is not a r++ command")
    end
  end
end
