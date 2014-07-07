require 'spec_helper'

describe Blockhead::Extractors::Abstract, '#valid?' do
  let(:blank) { Blockhead::Extractors::Abstract.new(nil, nil, nil) }

  it 'fails with "#valid? not implemented"' do
    expect { blank.valid? }.to raise_error RuntimeError
  end

end

describe Blockhead::Extractors::Abstract, '#extract_value' do
  let(:blank) { Blockhead::Extractors::Abstract.new(nil, nil, nil) }

  it 'fails with #extract_value not implemented' do
    expect { blank.extract_value }.to raise_error RuntimeError
  end
end

describe Blockhead::Extractors::Abstract, '#extract' do
  let(:blank) { Blockhead::Extractors::Abstract.new(nil, nil, nil) }

  it 'receives #extract_value when valid? is true' do
    allow(blank).to receive(:valid?) { true }
    expect(blank).to receive(:extract_value)

    blank.extract
  end

  it '@next receives #extract when valid? is false' do
    link = double
    blank.next = link

    allow(blank).to receive(:valid?) { false }
    expect(link).to receive(:extract)

    blank.extract
  end
end
