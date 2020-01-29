class Player
  # player information
  attr_reader :name, :score

  # create the player
  def initialize
    @name = ''
    @score = 0
  end

  # asks for and sets a name for a player
  def create_player(player)
    puts 'Enter the name for ' + player + ':'
    @name = gets.chomp
  end

  # function to switch which player
  def switch_player(player0_name)
    if @name == player0_name
      return 1
    else
      return 0
    end
  end

  # functions that alter the players score
  def increase_points
    @score += 2
  end

  def decrease_points (value)
    @score -= value
  end
end