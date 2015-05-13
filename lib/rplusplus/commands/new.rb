module RPlusPlus
  module Commands
    class New
      Command.register :new, self

      def self.call project_name, *args
        FileUtils.mkdir project_name

        File.write("#{project_name}/#{project_name.underscore}.cpp", main_erb.result(binding))
        File.write("#{project_name}/Rakefile", rakefile_erb.result(binding))
        File.write("#{project_name}/.gitignore", gitignore_erb.result(binding))
      end

      class << self
        private
        def template_dir
          File.join File.dirname(__FILE__), '../templates'
        end

        def main_erb
          ERB.new(File.read(File.join(template_dir, 'main.erb')))
        end

        def rakefile_erb
          ERB.new(File.read(File.join(template_dir, 'Rakefile.erb')))
        end

        def gitignore_erb
          ERB.new(File.read(File.join(template_dir, 'gitignore.erb')))
        end
      end
    end
  end
end
