module Blockhead
  class AliasKey
    attr_reader :default, :alias_key

    def initialize(name, alias_key)
      @default = name
      @alias_key = alias_key
    end

    def key
      send(:"alias_#{aliased_key?}")
    end

    private

    def alias_true
      raise TypeError, 'Alias is not of expected type' if bad_type?
      alias_key[:as]
    end

    def alias_false
      default
    end

    def aliased_key?
      alias_key.is_a?(Hash) && alias_key.has_key?(:as)
    end

    def bad_type?
      !(alias_key[:as].is_a?(Symbol) || alias_key[:as].is_a?(String))
    end
  end
end
