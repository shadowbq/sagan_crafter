module SaganCrafter
  class Ruleset
    attr_reader :rules

    def initialize(rule_sources, existing_connection=nil)
      @rules_builders = []
      @rules = []
      @connection = existing_connection
      rule_sources.each do |source|
        @rules << new_rule_source(source)
      end
      @rules
    end

    def to_s
      @rules.to_s
    end

    def new_rule_source(source)
      raise TemplateError, "new_rule_source called on template class Ruleset"
    end

  end

  class FQDNRuleset < Ruleset
    def new_rule_source(source)
      puts "#[sagan-crafter] #{self.class} - #{source}" if SaganCrafter::Settings.verbose
      printer = SaganCrafter::Backends::SQLite.new(SaganCrafter::Factory::FQDNlogger.new, @connection)
      printer.validate!
      return printer.build
    end
  end

  class IPRuleset < Ruleset
    def new_rule_source(source)
      puts "#[sagan-crafter] #{self.class} - #{source}" if SaganCrafter::Settings.verbose
      printer = SaganCrafter::Backends::SQLite.new(SaganCrafter::Factory::IPlogger.new, @connection)
      printer.validate!
      return printer.build
    end
  end

end
