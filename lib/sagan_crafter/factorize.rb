module SaganCrafter
  class Factorize

    def self.register(factory_type)
      case factory_type.downcase
        when /fqdnlogger/
          return SaganCrafter::Factory::FQDNlogger.new
        when /iplogger/
          return SaganCrafter::Factory::IPlogger.new
        else
          raise UnknownFactoryError, "Missing Class for generator invocation: (#{type})"
      end
    end

  end
end

$:.unshift(File.dirname(__FILE__))
%w( fqdnlogger iplogger ).each do |lib|
  begin
    require "factory/#{lib}"
  rescue LoadError
    require File.expand_path(File.join(File.dirname(__FILE__), "factory", lib))
  end
end
