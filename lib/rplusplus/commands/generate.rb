module RPlusPlus
  module Commands
    class Generate
      Command.register :generate, self

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
        name = name.to_sym
        if !self.generators.has_key? name
          raise MissingGeneratorError.new("'#{name}' is not a r++ generator")
        end
        self.generators[name].call *args
      end

      class MissingGeneratorError < StandardError
      end
    end
  end
end
