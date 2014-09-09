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
      key = OptionKey.new(name, arg).key
      attributes[key] = ValueExtractor.new(_call(name), arg, &block).extract
    end

    private

    attr_reader :arg

    def _call(name)
      if @arg == :wrap
        object
      elsif valid_message?(name)
        object.send name
      end
    end

    def valid_message?(name)
      object.respond_to?(name) && !object.nil? # nil responds to :id in Rails.
    end
  end
end
