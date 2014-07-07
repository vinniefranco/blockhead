require 'spec_helper'

describe Blockhead::Extractors::Value, '#valid?' do
  it 'returns true' do
    extractor = Blockhead::Extractors::Value.new('test', [], nil)
    expect(extractor).to be_valid
  end
end

describe Blockhead::Extractors::Value, '#extract_value' do
  it 'returns @value unmolested' do
    extractor = Blockhead::Extractors::Value.new('test', [], nil)
    expect(extractor.extract_value).to eq 'test'
  end
end
