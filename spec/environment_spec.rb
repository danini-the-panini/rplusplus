require 'spec_helper'

describe RPlusPlus::Environment do
  let(:env) { RPlusPlus::Environment.new }

  before(:all) do
    Dir.chdir('spec/support/samples')
  end

  describe '#objects' do
    it 'contains a list of objects with their dependencies' do
      expect(env.objects).to include(
        'my_class.o', 'other_class.o', 'foo/bar.o','erb_class.o')
      expect(env.objects['my_class.o']).to contain_exactly(
        'my_class.cpp', 'my_class.h', 'other_class.h', 'foo/bar.h', 'foo/baz.h', 'foo/quz.h',
        'erb_class.h'
      )
      expect(env.objects['erb_class.o']).to contain_exactly(
        'erb_class.cpp', 'erb_class.h'
      )
    end
  end

  describe '#builds' do
    it 'contains a list of builds and their dependencies' do
      expect(env.builds).to include(
        'main', 'other_main'
      )
      expect(env.builds['main']).to contain_exactly(
        'my_class.o', 'other_class.o', 'erb_class.o', 'foo/bar.o', 'main.o'
      )
      expect(env.builds['other_main']).to contain_exactly(
        'erb_class.o', 'other_main.o'
      )
    end
  end

  describe '#erbs' do
    it 'contains a list of files to be generated with erb' do
      expect(env.erbs).to include(
        'erb_class.cpp' => ['erb_class.cpp.erb'],
        'erb_class.h' => ['erb_class.h.erb']
      )
    end
  end
end
