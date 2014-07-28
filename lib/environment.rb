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
          hash[e[0..-5]] = e
        end
        hash
      end

      def objects_hash
        @cpp_info ||= info_hash('cpp')
        @header_info ||= info_hash('h')

        hash = {}
        @cpp_info.each do |cpp,info|
          hash[objectify cpp] = [cpp] | deps_for(info)
        end
        hash
      end

      def deps_for info
        info[:deps] | info[:deps].map do |d|
          deps_for(@header_info[d])
        end.flatten
      end

      def builds_hash
        objects
        hash = {}
        @cpp_info.each do |cpp,info|
          next unless info[:main]

          hash[basename cpp] = objects[objectify cpp].map do |d|
            objectify d
          end.keep_if do |d|
            objects.include? d
          end
        end
        hash
      end

      def info_hash type
        hash = {}
        Dir[Pathname(@path).join("**/*.#{type}")].each do |f|
          hash[f] = info_for f
        end
        Dir[Pathname(@path).join("**/*.#{type}.erb")].each do |f|
          hash[unerb(f)] = info_for f
        end
        hash
      end

      def info_for fn
        main = false
        deps = []
        File.foreach(fn) do |l|
          main ||= !!main_match(l)
          dep = include_match l
          deps << dep if dep
        end
        {main: main, deps: deps}
      end

      def unerb fn
        fn.gsub(/\.erb$/,'')
      end

      def basename fn
        fn.gsub(/\..*$/,'')
      end

      def main_match l
        l =~ /^\W*int\W*main\(.*?\)/
      end

      def include_match l
        m = /#include "(?<file>.*)"/.match(l)
        m[:file] if m
      end

      def objectify filename
        filename.gsub(/\.(cpp|cpp\.erb|h|h\.erb)$/,'.o')
      end

  end
end
