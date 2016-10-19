module SaganCrafter
  class Generator

    def configure(hosts)
      @logger.debug "No post-provisioning configuration necessary for #{self.class.name} boxes"
    end

    def self.register type, hosts_to_provision, options, config
      case type.downcase
        when /fqdnlogger/
          return SaganCrafter::Generator::FQDNlogger.new hosts_to_provision, options, config
        when /iplogger/
          return SaganCrafter::Generator::IPlogger.new hosts_to_provision, options, config
        else
          raise UnknownGeneratorError, "Missing Class for generator invocation: (#{type})"
      end
    end

  end
end

%w( fqdnlogger iplogger ).each do |lib|
  begin
    require "generators/#{lib}"
  rescue LoadError
    require File.expand_path(File.join(File.dirname(__FILE__), "generators", lib))
  end
end
