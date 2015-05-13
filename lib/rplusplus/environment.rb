require 'pathname'
require 'erb'

module RPlusPlus
  class Environment

    def initialize path='.'
      @path = path
    end

    def objects
      @objects ||= objects_hash
    end

    def builds
      @builds ||= builds_hash
    end

    def erbs
      @erbs ||= erbs_hash
    end

    private

      def erbs_hash
        hash = {}
        Dir[Pathname(@path).join('**/*.erb')].each do |e|
          hash[e[0..-5]] = [e]
        end
        hash
      end

      def objects_hash
        @cpp_metadata ||= metadata_for_filetype('cpp')
        @header_metadata ||= metadata_for_filetype('h')

        @cpp_metadata.each_with_object({}) do |(cpp_file, metadata), hash|
          hash[objectify cpp_file] = [cpp_file] | dependencies_from_metadata(metadata)
        end
      end

      def dependencies_from_metadata metadata
        dependency_dependencies = metadata[:dependencies].flat_map do |dependency|
          dependencies_from_metadata(@header_metadata[dependency])
        end
        metadata[:dependencies] | dependency_dependencies
      end

      def builds_hash
        objects
        @cpp_metadata.each_with_object({}) do |(cpp_file, metadata), hash|
          hash[File.basename cpp_file, '.cpp'] = object_dependencies objectify(cpp_file) if metadata[:is_main]
        end
      end

      def object_dependencies object_file, visited=[]
        objects[object_file].each_with_object([]) do |source_dependency, dependencies|
          object_dependency = objectify(source_dependency)
          if !visited.include?(object_dependency) && objects.include?(object_dependency)
            dependencies << object_dependency
            dependencies |= object_dependencies(object_dependency, [object_dependency, *visited])
          end
        end
      end

      def metadata_for_filetype type
        metadata = Dir[Pathname(@path).join("**/*.#{type}")].each_with_object({}) do |filename, hash|
          hash[filename] = metadata_for filename
        end
        Dir[Pathname(@path).join("**/*.#{type}.erb")].each_with_object(metadata) do |filename, hash|
          hash[File.basename filename, '.erb'] = metadata_for filename
        end
      end

      def metadata_for filename
        is_main = false
        dependencies = []
        File.foreach(filename) do |line|
          is_main ||= is_main_declaration(line)
          dependency = get_included_file line
          dependencies << dependency if dependency
        end
        {is_main: is_main, dependencies: dependencies}
      end

      def is_main_declaration line
        !!(line =~ /^\W*int\W*main\(.*?\)/)
      end

      def get_included_file line
        m = /#include "(?<file>.*)"/.match(line)
        m[:file] if m
      end

      def objectify filename
        filename.gsub(/\.(cpp|cpp\.erb|h|h\.erb)$/,'.o')
      end
  end
end
