require 'optparse'
require 'sagan_crafter'

module SaganCrafter

    class CLI

      def self.invoke
        self.new
      end

      def initialize
        options = {}

        options[:cxtracker] = false
        options[:passivedns] = false

        options[:sqlite] = false
        options[:sqlite_location] = '/tmp/threat.db'

        options[:raw] = SaganCrafter::Defaults::Raw

        opt_parser = OptionParser.new do |opt|
          opt.banner = "Usage: sagan-crafter"
          opt.separator ""

          opt.on("-c", "--cxtracker", "Create CXTracker rules") do
            options[:cxtracker] = true
          end

          opt.on("-p", "--passivedns", "Create Passivedns rules") do
            options[:passivedns] = true
          end

          opt.separator ""

          opt.separator "Backend"
          opt.separator ""

          opt.on("-s", "--sqlite=", "Sqlite3 backend file location","  Default: #{options[:sqlite_location]}") do |value|
            options[:sqlite] = true
            options[:sqlite_location] = value
          end

          opt.separator "Options::"

          opt.on("-v", "--verbose", "Run verbosely") do
            options[:verbose] = true
          end

          opt.on_tail("-h","--help","Display this screen") do
            puts opt_parser
            exit 0
          end

        end

        #Verify the options
        begin
          raise unless ARGV.size > 0
          opt_parser.parse!

        #If options fail display help
        #rescue Exception => e
        #  puts e.message
        #  puts e.backtrace.inspect
        rescue
          puts opt_parser
          exit
        end

        # Boolean switch
        SaganCrafter::Settings.verbose = options[:verbose]

        if SaganCrafter::Settings.verbose
          puts "++++++++++++++++++++++++++++++++++++++++++++++"
          puts "+ Sagan-Crafter!"
          puts "++++++++++++++++++++++++++++++++++++++++++++++\n"
        end

        puts  Settings.verbose
        printer = SaganCrafter::Backends::SQLite.new(options[:sqlite_location])
        printer.validate!
        printer.print
        #session = SaganCrafter::Gonna.new
        #session.login(username, password)

        #puts session.search("example.com")

      end

    end #Class


end #module
