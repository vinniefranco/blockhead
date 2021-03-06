require 'spec_helper'

describe Blockhead::Extractors::Enumerable, '#valid?' do
  it 'is valid with a @proc and a array @value' do
    extractor = enum_factory([], Proc.new { 'Test.' })
    expect(extractor).to be_valid
  end

  it 'is invalid without a @proc' do
    extractor = enum_factory([], nil)
    expect(extractor).to_not be_valid
  end

  it 'is invalid with the incorrect @value type' do
    extractor = enum_factory('', Proc.new { title })
    expect(extractor).to_not be_valid
  end
end

describe Blockhead::Extractors::Enumerable, '#extract_value' do
  it 'passes elements in value to Schema with @proc' do
    item = double(title: 'Foo')
    extractor = enum_factory([item], Proc.new { title })
    expect(extractor.extract_value).to eq [{ title: 'Foo' }]
  end
end

def enum_factory(object, proc = nil)
  Blockhead::Extractors::Enumerable.new(object, nil, proc)
end
