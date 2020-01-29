require_relative 'player'

class MultiPlayer < Player
  attr_reader :players, :num_players, :current_player_index
  
  def initialize(num_players)
    @num_players = num_players
    @players = []
    @current_player_index = nil
    (0..num_players - 1).each { |i| @players[i] = Player.new}
  end

  def create_all_players
    (0..num_players - 1).each { |i| @players[i].create_player('Player' + i.to_s)}
  end

  def determine_starting_player
    @current_player_index = rand(0..num_players - 1)
    puts "Looks like #{@players[@current_player_index].name} will be going first!"
    @players[@current_player_index]
  end
  
  def switch_players
    @current_player_index += 1
    @current_player_index = 0 if @current_player_index >= @num_players
    @players[@current_player_index]
  end
  
  def print_scores_and_determine_winner
    puts '\nScores:'
    winner = @players[0]
    (0..num_players - 1).each do |i|
      puts "\n#{@players[i].name} : #{@players[i].score}"
      winner = @players[i] if @players[i].score > winner.score
    end
    puts 'Congratulations ' + winner.name + "!! You win!!\n"
  end
end