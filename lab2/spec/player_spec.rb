require 'rspec'
require_relative '../player'

describe Player do
  before :each do
    @player = Player.new
  end

  describe "#new" do
    it "returns a Player object" do
      expect(@player.instance_of? Player).to eq true
    end
    it "creates a Player object with no name" do
      expect(@player.name).to eq ''
    end
    it "creates a Player object with score of 0" do
      expect(@player.score).to eq 0
    end
  end

  #Todo: test create_player and potentially rename that
    describe "#create_player" do
      it "changes player name" do
        STDOUT.should_receive(:puts).with("Enter the name for Player1:") #absorb console output and check it
        Player.any_instance.stub(gets: 'This name') #Fake user input
        expect(@player.create_player("Player1")).to eq "This name"
      end
    end
  # Todo: test increase_points
  #
  # Todo: test decrease_points

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end
end