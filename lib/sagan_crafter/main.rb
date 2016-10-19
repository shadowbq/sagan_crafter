module SaganCrafter

    class CustomError < StandardError; end
    class UnknownDBSchemaError < StandardError; end
    class UnknownGeneratorError < StandardError; end

    module Defaults
      Raw = false # SaganCrafter::Defaults::Raw
    end

end
