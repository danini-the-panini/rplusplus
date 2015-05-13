require 'active_support/all'

require "rplusplus/version"
require "rplusplus/environment"
require "rplusplus/command"
require "rplusplus/commands/generate"
require "rplusplus/generators/class_generator"
require "rplusplus/commands/new"

module RPlusPlus
  def self.call argv
    command, *arguments = *argv
    Command.call command, *arguments
  end
end
