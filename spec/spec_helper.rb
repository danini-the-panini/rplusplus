require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler/setup'

require 'rplusplus'

Dir[Pathname.new(File.dirname(__FILE__)).join("support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

end
