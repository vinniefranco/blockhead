require 'spec_helper'

describe Blockhead::Extractors::Value, '#valid?' do
  it 'returns true' do
    extractor = Blockhead::Extractors::Value.new('test', nil, nil)
    expect(extractor).to be_valid
  end
end

describe Blockhead::Extractors::Value, '#extract_value' do
  it 'returns @value unmolested' do
    extractor = Blockhead::Extractors::Value.new('test', nil, nil)
    expect(extractor.extract_value).to eq 'test'
  end

  it 'cleans up strings when passed with: :pretty_print' do
    extractor = Blockhead::Extractors::Value.new(
      "This is Crazy \n",
      { with: :pretty_print },
      nil
    )

    expect(extractor.extract_value).to eq 'This Is Crazy'
  end
end
