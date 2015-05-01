require 'spec_helper'

describe RPlusPlus::Commands::Generate do
  let(:fake_generator) { spy('generator') }

  after do
    RPlusPlus::Commands::Generate.generators.delete :test_generator
  end

  it 'registers itself with Command' do
    expect(RPlusPlus::Command.commands).to include(
      :generate => RPlusPlus::Commands::Generate)
  end

  describe '#register' do
    it 'registers a generator' do
      RPlusPlus::Commands::Generate.register(:test_generator, fake_generator)

      expect(RPlusPlus::Commands::Generate.generators).to include(
        :test_generator => fake_generator)
    end
  end

  describe '#list' do
    after do
      [:foo, :bar, :baz].each { |x| RPlusPlus::Commands::Generate.generators.delete x }
    end

    it 'lists all registered generators' do
      RPlusPlus::Commands::Generate.register(:foo, fake_generator)
      RPlusPlus::Commands::Generate.register(:bar, fake_generator)
      RPlusPlus::Commands::Generate.register(:baz, fake_generator)

      expect(RPlusPlus::Commands::Generate.list).to include(:foo, :bar, :baz)
    end
  end

  describe '#call' do
    before do
      RPlusPlus::Commands::Generate.register(:test_generator, fake_generator)
    end

    it 'runs the specified generator with the given arguments' do
      RPlusPlus::Commands::Generate.call(:test_generator, 'foobar')

      expect(fake_generator).to have_received(:call).with('foobar')
    end

    it 'raises if the specific generator does not exists' do
      expect {
        RPlusPlus::Commands::Generate.call :nonexistent, :something
      }.to raise_error(RPlusPlus::Commands::Generate::MissingGeneratorError,
        "'nonexistent' is not a r++ generator")
    end
  end
end
