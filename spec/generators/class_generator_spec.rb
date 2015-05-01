require 'spec_helper'

describe RPlusPlus::Generators::ClassGenerator do
  it 'registers itself with the generate command' do
    expect(RPlusPlus::Commands::Generate.generators).to include(:class => RPlusPlus::Generators::ClassGenerator)
  end

  describe '#call' do
    # include FakeFS::SpecHelpers

    before(:all) do
      @pwd = Dir.pwd
      Dir.chdir('spec/support/sandbox')
    end

    after(:all) do
      Dir.chdir(@pwd)
    end

    after do
      FileUtils.rm 'my_class.h'
      FileUtils.rm 'my_class.cpp'
    end

    it 'generates a class' do
      RPlusPlus::Generators::ClassGenerator.call('MyClass')

      header_file = File.read('my_class.h')
      class_file = File.read('my_class.cpp')

      expect(header_file).to include('#ifndef MY_CLASS_H', '#define MY_CLASS_H', 'class MyClass {', 'MyClass();', 'virtual ~MyClass();')
      expect(class_file).to include('#include "my_class.h"', 'MyClass::MyClass() {', 'MyClass::~MyClass() {')
    end
  end
end
