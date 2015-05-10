require 'spec_helper'

describe RPlusPlus do
  describe '#call' do
    let (:fake_command) { spy('fake_command') }

    before do
      RPlusPlus::Command.register :test_command, fake_command
    end

    after do
      RPlusPlus::Command.commands.delete :test_command
    end

    it 'calls the specified command with the given arguments' do
      RPlusPlus.call ['test_command', 'foo', 'bar', 'baz']

      expect(fake_command).to have_received(:call).with('foo', 'bar', 'baz')
    end
  end
end
