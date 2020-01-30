require 'rspec'
require_relative '../deck'

describe Deck do
  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end
end