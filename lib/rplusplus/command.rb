module RPlusPlus
  class Command
    def self.commands
      @@commands ||= {}
    end

    def self.register name, command
      self.commands[name] = command
    end

    def self.list
      self.commands.keys
    end

    def self.call name, *args
      name = name.to_sym
      if !self.commands.has_key? name
        raise MissingCommandError.new("'#{name}' is not a r++ command")
      end
      self.commands[name].call(*args)
    end

    class MissingCommandError < StandardError
    end
  end
end
