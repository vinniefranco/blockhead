require 'spec_helper'

describe Blockhead::Extractors::Block, '#valid?' do
  it 'is valid when @proc is assigned' do
    object = double('poro', title: 'This')
    extractor = Blockhead::Extractors::Block.new object, [], -> { title }

    expect(extractor.extract_value).to eq 'This'
  end
end
