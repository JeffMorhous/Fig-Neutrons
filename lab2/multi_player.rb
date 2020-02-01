require_relative 'player'
# This creates multiple playe

class MultiPlayer < Player
  attr_reader :players, :num_players, :current_player_index

  # create an array of players
  def initialize(num_players)
    @num_players = num_players
    @players = []
    @current_player_index = nil
    (0..num_players - 1).each { |i| @players[i] = Player.new}
  end

  # allows you to name all the players in the array
  def name_all_players
    (0..num_players - 1).each { |i| @players[i].name_player('Player' + i.to_s)}
  end

  # randomly pick a starting player
  def determine_starting_player
    @current_player_index = rand(0..num_players - 1)
    puts "Looks like #{@players[@current_player_index].name} will be going first!"
    @players[@current_player_index]
  end

  # alternate between the players
  def switch_players
    @current_player_index += 1
    @current_player_index = 0 if @current_player_index >= @num_players
    @players[@current_player_index]
  end

  # print the final scores and determine if there is a winner or a tie
  def print_scores_and_determine_winner
    tie = false
    puts "\nScores:"
    winner = @players[0]
    (0..num_players - 1).each do |i|
      puts "\n#{@players[i].name} : #{@players[i].score}"
      tie = @players[i].score == winner.score ? true : false
      winner = @players[i] if @players[i].score > winner.score
    end
    
    puts "\nIt was tie!" if tie == true
    puts "Congratulations "  + winner.name + "!! You win!!\n" if tie == false
  end
end