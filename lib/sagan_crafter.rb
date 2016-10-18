require 'rubygems'
require "sagan_crafter/version"
require 'snort/rule'
require 'sqlite3'
require 'xxhash'
require 'pry'

module SaganCrafter
  $:.unshift(File.dirname(__FILE__))
  XX="myconstant"

  require "sagan_crafter/main"
  require "sagan_crafter/settings"
  require "sagan_crafter/version"
  require "sagan_crafter/backends/sqlite"
  require "sagan_crafter/generators/pdns"
  require "sagan_crafter/generators/cxtracker"
end
