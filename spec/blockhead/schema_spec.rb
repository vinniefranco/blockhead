require 'spec_helper'
require 'ostruct'

describe Blockhead::Schema, '::define' do
  class Tester
    def title
      'Title'
    end

    def description
      'Description'
    end

    def nested_array
      [OpenStruct.new(sku: '1234')]
    end

    def nested_obj
      OpenStruct.new(sku: '4321', price: OpenStruct.new(base: 1200))
    end
  end

  it 'returns a hash' do
    schema = schema_with { title }

    expect(schema.marshal).to be_a Hash
  end

  it 'marshals objects methods' do
    schema = schema_with do
      title
      description
    end

    expect(schema.marshal).to eq title: 'Title', description: 'Description'
  end

  it 'handles nil attributes' do
    schema = schema_with do
      title
      description
      not_found
    end
    response = { title: 'Title', description: 'Description', not_found: nil }
    expect(schema.marshal).to eq response
  end

  it 'accepts hash aliases' do
    schema = schema_with do
      title as: 'header'
      description as: 'body'
    end

    expect(schema.marshal).to eq 'header' => 'Title', 'body' => 'Description'
  end

  it 'accepts procs' do
    schema = schema_with do
      summary ->{ "#{object.title} #{object.description}" }
    end

    expect(schema.marshal).to eq summary: 'Title Description'
  end

  it 'handles nested objects' do
    schema = schema_with do
      nested_obj do
        sku
        price do
          base
        end
      end
    end

    expect(schema.marshal).to eq nested_obj: {sku: '4321', price: {base: 1200}}
  end

  it 'handles nested objects with aliases' do
    schema = schema_with do
      nested_obj as: :cart do
        sku
        price do
          base as: :cost
        end
      end
    end

    expect(schema.marshal).to eq cart: {sku: '4321', price: {cost: 1200}}
  end


  def schema_with(&block)
    Blockhead::Schema.define(Tester.new, &block)
  end
end
