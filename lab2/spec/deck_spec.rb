require 'rspec'
require_relative '../deck'

#Todo: more fleshed out testing
#
describe Deck do
  before :each do
    @deck = Deck.new
  end

  describe "#new" do
    it "returns a Deck object" do
      expect(@deck.instance_of? Deck).to eq true
    end
  end

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end
end