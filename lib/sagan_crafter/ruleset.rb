module SaganCrafter
  class Ruleset
    def initialize(rule_sources)
      @rules_builders = []
      rule_sources.each do |rs|
        rule = new_rule_source(rs)
        puts "here"
        @rules << rule
      end
    end

    def build
      @rules_builders.each {|builder| builder.build}
    end
  end

  class FQDNRuleset < Ruleset
    def new_rule_source(rs)
      puts rs
      printer = SaganCrafter::Backends::SQLite.new(options[:sqlite_location], SaganCrafter::Generators::FQDNlogger.new )
      printer.validate!
      printer.print
    end
  end

  class IPRuleset < Ruleset
    def new_rule_source(rs)
      puts rs
      printer = SaganCrafter::Backends::SQLite.new(options[:sqlite_location], SaganCrafter::Generators::IPlogger.new )
      printer.validate!
      printer.print
    end
  end

end
