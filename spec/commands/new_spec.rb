require 'spec_helper'

describe RPlusPlus::Commands::New do
  it 'registers itself with Command' do
    expect(RPlusPlus::Command.commands).to include(:new => RPlusPlus::Commands::New)
  end

  describe '#call' do
    before(:all) do
      @pwd = Dir.pwd
      Dir.chdir('spec/support/sandbox')
    end

    after(:all) do
      Dir.chdir(@pwd)
    end

    after do
      FileUtils.rm_rf 'my_project'
    end

    it 'creates a new folder with the project name' do
      RPlusPlus::Commands::New.call('my_project')

      expect(File).to be_directory('my_project')
    end

    it 'creates a starting main file with the project name' do
      RPlusPlus::Commands::New.call('my_project')

      expect(File).to exist('my_project/my_project.cpp')
      main_cpp = File.read 'my_project/my_project.cpp'

      expect(main_cpp).to include 'int main(int argc, char* argv[])'
      expect(main_cpp).to include 'return 0;'
    end

    it 'creates a starting Rakefile with the executable as the default task' do
      RPlusPlus::Commands::New.call('my_project')

      expect(File).to exist('my_project/Rakefile')
      rakefile = File.read 'my_project/Rakefile'

      expect(rakefile).to include "require 'rplusplus'"
      expect(rakefile).to include "env = RPlusPlus::Environment.new"
      expect(rakefile).to include 'task :default => :all'
      expect(rakefile).to include "task :all => ['my_project']"
    end

    it 'creates a .gitignore that ignores *.o files and the main executable' do
      RPlusPlus::Commands::New.call('my_project')
      expect(File).to exist('my_project/.gitignore')
      gitignore = File.read 'my_project/.gitignore'

      expect(gitignore).to include '*.o'
      expect(gitignore).to include 'my_project'
    end
  end
end
