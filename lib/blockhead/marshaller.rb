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
      @arg = args.first
      key = OptionKey.new(name, @arg).key
      attributes[key] = ValueExtractor.new(_call(name), *args, &block).extract
    end

    private

    def _call(name)
      if @arg == :wrap
        object
      elsif object.respond_to?(name)
        object.send name
      end
    end
  end
end
