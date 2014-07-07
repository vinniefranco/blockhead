require 'spec_helper'

describe Blockhead::Extractors::Proc, '#valid?' do
  it 'is valid when a proc is passed in as the first argument' do
    expect(proc_factory).to be_valid
  end
end

describe Blockhead::Extractors::Proc, '#extract_value' do
  it "uses the body of the proc as it's extracted value" do
    expect(proc_factory.extract_value).to eq 'test'
  end

  it 'has @value within scope on extract' do
    value = double(title: 'This')
    proc = proc_factory(-> { "#{value.title} is a title" }, value)
    expect(proc.extract_value).to eq 'This is a title'
  end
end

def proc_factory(proc = -> { 'test' }, value = nil)
  Blockhead::Extractors::Proc.new value, proc, nil
end
