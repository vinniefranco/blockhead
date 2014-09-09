module Blockhead
  class OptionKey
    attr_reader :default, :options

    def initialize(name, options)
      @default = name
      @options = options
    end

    def key
      if options?
        raise TypeError, 'Aliase is not of expected type' if bad_type?
        options[:as]
      else
        default
      end
    end

    private

    def options?
      options.is_a?(Hash) && options.has_key?(:as)
    end

    def bad_type?
      !(options[:as].is_a?(Symbol) || options[:as].is_a?(String))
    end
  end
end
