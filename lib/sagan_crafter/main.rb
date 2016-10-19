module SaganCrafter

    class CustomError < StandardError; end
    class UnknownDBSchemaError < StandardError; end
    class UnknownFactoryError < StandardError; end

    module Defaults
      Raw = false # SaganCrafter::Defaults::Raw
    end

end
