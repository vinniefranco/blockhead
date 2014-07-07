require 'spec_helper'

describe Blockhead::Extractors::Array, '#valid?' do
  it 'is valid with a @proc and a array @value' do
    extractor = Blockhead::Extractors::Array.new([], [], -> { 'Test.' })
    expect(extractor).to be_valid
  end

  it 'is invalid without a @proc' do
    extractor = Blockhead::Extractors::Array.new([], [], nil)
    expect(extractor).to_not be_valid
  end

  it 'is invalid with the incorrect @value type' do
    extractor = Blockhead::Extractors::Array.new('', [], nil)
    expect(extractor).to_not be_valid
  end
end

describe Blockhead::Extractors::Array, '#extract_value' do
  it 'passes elements in value to Schema with @proc' do
    item = double(title: 'Foo')
    extractor = Blockhead::Extractors::Array.new([item], [], Proc.new { title })

    expect(extractor.extract_value).to eq [{ title: 'Foo' }]
  end
end
