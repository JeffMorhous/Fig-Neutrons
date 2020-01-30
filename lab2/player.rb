class Player
  # player information
  attr_reader :name, :score

  # create the player
  def initialize
    @name = ''
    @score = 0
  end

  # asks for and sets a name for a player
  def name_player(player)
    puts 'Enter the name for ' + player + ':'
    @name = gets.chomp
  end

  # functions that alter the players score
  def increase_points
    @score += 3
  end

  def decrease_points (value)
    @score -= value
  end
end