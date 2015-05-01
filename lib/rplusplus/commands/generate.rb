module RPlusPlus
  module Commands
    class Generate
      def self.generators
        @@generators ||= {}
      end

      def self.register name, generator
        self.generators[name.to_sym] = generator
      end

      def self.list
        self.generators.keys
      end

      def self.call name, *args
        self.generators[name].call *args
      end
    end
  end
end
