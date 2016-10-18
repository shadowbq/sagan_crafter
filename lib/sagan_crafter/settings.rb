module SaganCrafter
  module Settings
    extend self

    @@registered_settings = []

    # SaganCrafter provides a basic single-method DSL with .parameter method
    # being used to define a set of available settings.
    # This method takes one or more symbols, with each one being
    # a name of the configuration option.
    def parameter(*names)
      names.each do |name|
        attr_accessor name

        @@registered_settings.push(name)

        # For each given symbol we generate accessor method that sets option's
        # value being called with an argument, or returns option's current value
        # when called without arguments
        undef_method name if method_defined? name

        define_method name do |*values|
          value = values.first
          if value
            send("#{name}=", value)
          else
            instance_variable_defined?("@#{name}") ?  instance_variable_get("@#{name}") : nil
          end
        end
      end
    end

    # And we define a wrapper for the configuration block, that we'll use to set up
    # our set of options
    def config &block
      instance_eval(&block)
    end

    # list available settings
    def self.list
      @@registered_settings
    end

    def self.reset!
      self.config do
        verbose false
      end
    end

    def self.to_h
      c = {}
      SaganCrafter::Settings.list.each do |toggle|
        c[toggle.to_sym] = SaganCrafter::Settings.send(toggle)
      end
      return c
    end

    def self.print
      SaganCrafter::Settings.list.each do |toggle|
        puts "#{toggle} => #{SaganCrafter::Settings.send(toggle)}"
      end
    end

  end

  # [1] pry(#<SaganCrafter::CLI>)> Settings.list
  # => [:verbose]

  Settings.config do
    parameter :verbose
  end

  Settings.reset!
end
