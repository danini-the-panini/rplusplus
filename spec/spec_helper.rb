require 'bundler/setup'
require 'fakefs/spec_helpers'

require 'rplusplus'

Dir[Pathname.new(File.dirname(__FILE__)).join("support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

end
