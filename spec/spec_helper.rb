$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sagan_crafter'

require 'pathname'
SPEC_ROOT = Pathname.new(__FILE__).dirname.expand_path
PROJECT_ROOT =  SPEC_ROOT.join('../').expand_path
SUPPORT_ROOT = SPEC_ROOT.join('support')

Dir.glob(SUPPORT_ROOT.join('**','*.rb')).sort.each { |f| require f}

RSpec.configure do |config|
  config.include SQLite3helper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
