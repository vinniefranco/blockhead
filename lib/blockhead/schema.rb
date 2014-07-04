module Blockhead
  class Marshaller < BasicObject
    def initialize(object)
      @attributes = {}
      @object = object
    end

    attr_reader :attributes, :object

    def marshal
      attributes
    end

    def _delegate(name, *args)
      if object.respond_to?(name)
        object.send name
      else
        nil
      end
    end

    def method_missing(name, *args, &block)
      case args.first
      when ::Hash
        attr = args.first[:as]
      when ::Proc
        return attributes[name] = args.first.call
      else
        attr = name
      end

      attributes[attr] = _delegate(name, *args)
      if block
        attributes[attr] = Schema.define(attributes[attr], &block).marshal
      end
    end
  end
  class Schema
    attr_reader :object

    def self.define(object, &block)
      new(object).define(&block)
    end

    def initialize(object)
      @object = object
    end

    def define(&block)
      raise 'No schema definition' unless block_given?
      schema = Marshaller.new(object)
      schema.instance_eval(&block) 

      schema
    end
  end
end
