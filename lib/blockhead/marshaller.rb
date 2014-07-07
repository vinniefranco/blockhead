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
      attributes[key] = ValueExtractor.new(_call(name), *args, &block).extract
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
