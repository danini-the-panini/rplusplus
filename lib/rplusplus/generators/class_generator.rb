module RPlusPlus
  module Generators
    class ClassGenerator
      Commands::Generate.register :class, self

      def self.call class_name
        File.write("#{class_name.underscore}.h", header_erb.result(binding))
        File.write("#{class_name.underscore}.cpp", class_erb.result(binding))
      end

      class << self
        private
        def template_dir
          File.join File.dirname(__FILE__), '../templates'
        end

        def class_erb
          ERB.new(File.read(File.join(template_dir, 'class.erb')))
        end

        def header_erb
          ERB.new(File.read(File.join(template_dir, 'class_header.erb')))
        end
      end
    end
  end
end
