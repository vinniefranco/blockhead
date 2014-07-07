module Blockhead
  class Schema
    attr_reader :object

    def self.define(object, &block)
      new(object).define(&block)
    end

    def initialize(object)
      @object = object
    end

    def define(&block)
      fail 'No schema definition' unless block
      schema = Marshaller.new(object)
      schema.instance_eval(&block)

      schema
    end
  end
end
