require 'spec_helper'

describe RPlusPlus::Commands::Generate do
  let(:fake_generator) { spy('generator') }

  after do
    RPlusPlus::Commands::Generate.generators.clear
  end

  describe '#register' do
    it 'registers a generator' do
      RPlusPlus::Commands::Generate.register(:thing, fake_generator)

      expect(RPlusPlus::Commands::Generate.generators).to include(:thing => fake_generator)
    end
  end

  describe '#list' do
    it 'lists all registered generators' do
      RPlusPlus::Commands::Generate.register(:foo, spy('foo'))
      RPlusPlus::Commands::Generate.register(:bar, spy('bar'))
      RPlusPlus::Commands::Generate.register(:baz, spy('baz'))

      expect(RPlusPlus::Commands::Generate.list).to eq [:foo, :bar, :baz]
    end
  end

  describe '#call' do
    before do
      RPlusPlus::Commands::Generate.register(:thing, fake_generator)
    end

    it 'runs the specified generator with the given arguments' do
      RPlusPlus::Commands::Generate.call(:thing, 'foobar')

      expect(fake_generator).to have_received(:call).with('foobar')
    end
  end
end
