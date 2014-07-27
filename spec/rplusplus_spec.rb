require 'spec_helper'

describe RPlusPlus do
  describe '#immediate_deps' do
    it 'builds a set of dependent header files' do
      list = RPlusPlus.immediate_deps(load_file 'samples/my_class.cpp')

      expect(list).to be_a(Set).
        and contain_exactly('my_class.h','foo/baz.h')
    end
  end

  describe '#objectify' do
    it 'returns the o-file of the cpp' do
      expect(RPlusPlus.objectify 'my_class.cpp').to eq('my_class.o')
    end
  end

  describe '#deps' do
    it 'builds a set of dependent files' do
      Dir.chdir('spec/support/samples') do
        list = RPlusPlus.deps('my_class.cpp')

        expect(list).to be_a(Set).
          and contain_exactly('my_class.h','other_class.h',
                              'foo/bar.h','foo/baz.h','foo/quz.h')
      end
    end
  end

  describe '#each_cpp' do
    it 'enumerates cpp files' do
      Dir.chdir('spec/support/samples') do
        expect { |b| RPlusPlus.each_cpp(&b) }.
          to yield_control.exactly(3).times
        expect( RPlusPlus.each_cpp ).
          to contain_exactly('my_class.cpp', 'other_class.cpp', 'foo/bar.cpp')
      end
    end
  end

  describe '#deps_hash' do
    it 'generates a Rakefile-friendly hash of object => source deps' do
      Dir.chdir('spec/support/samples') do
        deps_hash = RPlusPlus.deps_hash
        expect(deps_hash).to include(
          'my_class.o', 'other_class.o', 'foo/bar.o')
        expect(deps_hash['my_class.o']).to contain_exactly(
          'my_class.cpp', 'my_class.h', 'other_class.h', 'foo/bar.h', 'foo/baz.h', 'foo/quz.h'
        )
      end
    end
  end
end
