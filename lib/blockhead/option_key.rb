module Blockhead
  class OptionKey
    attr_reader :default, :options

    def initialize(name, options)
      @default = name
      @options = options
    end

    def key
      if has_options?
        options[:as]
      else
        default
      end
    end

    private

    def has_options?
      options.is_a?(Hash)
    end
  end
end
