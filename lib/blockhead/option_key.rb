module Blockhead
  class OptionKey
    attr_reader :default, :options

    def initialize(name, options)
      @default = name
      @options = options
    end

    def key
      key = extract_key
      raise TypeError, 'Aliases cannot be nil' unless key
      key
    end

    private

    def extract_key
      if options?
        options[:as]
      else
        default
      end
    end

    def options?
      options.is_a?(Hash)
    end
  end
end
