module Blockhead
  class KeyExtractor
    def initialize(name, *args)
      @default = name
      @options = args.first
    end

    def extract
      if has_options?
        @options[:as]
      else
        @default
      end
    end

    private

    def has_options?
      @options.is_a?(Hash)
    end
  end
end
