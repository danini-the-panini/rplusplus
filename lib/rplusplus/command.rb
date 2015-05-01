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
      self.commands[name].call(*args)
    end
  end
end
