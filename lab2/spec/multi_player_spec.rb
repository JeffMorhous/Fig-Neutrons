require 'rspec'
require_relative '../multi_player'
require_relative '../player'

describe MultiPlayer do
  numberOfPlayers = 2
  before :each do
    @players = MultiPlayer.new(numberOfPlayers)  #Instantiate a new multiplayer object with 2 players
  end

  describe "#new" do
    it "returns a MultiPlayer object" do
      expect(@players.instance_of? MultiPlayer).to eq true
    end
    it "number of players created matches argument" do
      expect(@players.players.size).to eq numberOfPlayers
      expect(@players.num_players).to eq numberOfPlayers
    end
    it "current player index is nil" do
      expect(@players.current_player_index).to eq nil
    end
    it "creates a MultiPlayer object that has an array of Player objects" do
      (0..numberOfPlayers - 1).each{ |i| expect(@players.players[i].instance_of? Player).to eq true }
    end
  end

  describe "#name_all_players" do
    it 'changes each player\'s name' do
      initPlayerNames = []
      @players.players.each do |player|
        initPlayerNames.append(player.name)
      end
      Player.stub(:puts) #absorb console output
      Player.any_instance.stub(gets: 'This name') #Fake user input
      @players.name_all_players
      (0..numberOfPlayers - 1).each{ |i| expect(@players.players[i].name).not_to eq initPlayerNames[i]}
    end
  end

  describe "#determine_starting_player" do
    it 'returns a player object' do
      object = @players.determine_starting_player
      expect(object.instance_of? Player).to eq true
    end
    it 'guarantees current player is not nil' do
      object = @players.determine_starting_player
      expect(@players.current_player_index.nil?).to_not eq true
    end
  end

  describe "#switch_players" do
    before :each do
      @players.determine_starting_player
    end
    it "changes the player index by 1, setting index to 0 if previous player was the last player" do
      initIndex = @players.current_player_index
      @players.switch_players
      if initIndex < (numberOfPlayers - 1)
        expect(@players.current_player_index).to eq (initIndex + 1)
      else
        expect(@players.current_player_index).to eq 0
      end
    end
  end

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end

  it 'inherits from Player' do
    expect(described_class < Player).to eq true
  end
end