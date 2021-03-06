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

    def empty_array
      []
    end
  end

  class BadFormatting
    def title
      " title and things\r\n  "
    end

    def another_field
      " another thing \n"
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

  it 'handles :id when nil responds to id (Rails)' do
    allow(nil).to receive(:respond_to?).with(:id).and_return(true)

    schema = Blockhead::Schema.define nil do
      id
    end

    expect(schema.marshal).to eq(id: nil)
  end

  it 'handles wrappers' do
    schema = schema_with do
      surprise :wrap do
        title
        description
      end
    end

    response = { surprise: { title: 'Title', description: 'Description' } }
    expect(schema.marshal).to eq response
  end

  it 'handles nested wrappers' do
    schema = schema_with do
      a :wrap do
        b :wrap do
          title
          description
        end
      end
    end

    response = { a: { b: { title: 'Title', description: 'Description' } } }
    expect(schema.marshal).to eq response
  end

  it 'handles wrappers around nested objects' do
    schema = schema_with do
      a :wrap do
        title
      end
      nested_obj do
        item :wrap do
          sku
        end
      end
    end

    response = { a: { title: 'Title' }, nested_obj: { item: { sku: '4321' } } }
    expect(schema.marshal).to eq response
  end

  it 'handles nested nils' do
    schema = schema_with do
      nope do
        more_nope do
          still_nope
        end
      end
    end

    expect(schema.marshal).to eq nope: { more_nope: { still_nope: nil } }
  end

  it 'accepts hash aliases' do
    schema = schema_with do
      title as: 'header'
      description as: 'body'
    end

    expect(schema.marshal).to eq 'header' => 'Title', 'body' => 'Description'
  end

  it 'raises TypeError on non symbol aliases' do
    expect do
      schema_with { title as: header }
    end.to raise_error TypeError, 'Alias is not of expected type'
  end

  it 'accepts procs' do
    schema = schema_with do
      summary -> { "#{object.title} #{object.description}" }
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
    result = { nested_obj: { sku: '4321', price: { base: 1200 } } }

    expect(schema.marshal).to eq result
  end

  it 'cleans fields when passed with: :pretty_print' do
    schema = schema_with(BadFormatting) do
      title with: :pretty_print
      another_field
    end.marshal

    expect(schema).to eq(
      title: 'Title And Things',
      another_field: " another thing \n"
    )
  end

  it 'allows multiple options on a field' do
    schema = schema_with(BadFormatting) do
      title with: :pretty_print, as: :alias
    end.marshal

    expect(schema).to eq alias: 'Title And Things'
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

    expect(schema.marshal).to eq cart: { sku: '4321', price: { cost: 1200 } }
  end

  it 'handles collections of objects' do
    schema = schema_with do
      nested_array as: :cart do
        sku
      end
    end

    expect(schema.marshal).to eq cart: [{ sku: '1234' }]
  end

  it 'handles empty collections' do
    schema = schema_with do
      title
      empty_array
    end

    expect(schema.marshal).to eq title: 'Title', empty_array: []
  end

  def schema_with(klass = Tester, &block)
    Blockhead::Schema.define(klass.new, &block)
  end
end
