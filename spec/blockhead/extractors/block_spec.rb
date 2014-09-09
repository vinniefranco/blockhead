require 'spec_helper'

describe Blockhead::Extractors::Block, '#valid?' do
  it 'is valid when @proc is assigned' do
    expect(block_factory).to be_valid
  end
end

describe Blockhead::Extractors::Block, '#extract_value' do
  it 'marshals objects through Schema.define' do
    expect(block_factory.extract_value).to eq title: 'This'
  end
end

def block_factory
  object = double('poro', title: 'This')
  Blockhead::Extractors::Block.new object, nil, Proc.new { title }
end
