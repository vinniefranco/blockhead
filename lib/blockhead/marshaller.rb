module Blockhead
  class Marshaller < BasicObject
    attr_reader :attributes, :object

    def initialize(object)
      @attributes = {}
      @object = object
    end

    def marshal
      attributes
    end

    def method_missing(name, *args, &block)
      key = OptionKey.new(name, args.first).key
      value = _call(name)

      attributes[key] = ValueExtractor.new(value, *args, &block).extract
    end

    private

    def _call(name)
      if object.respond_to?(name)
        object.send name
      else
        nil
      end
    end
  end
end
