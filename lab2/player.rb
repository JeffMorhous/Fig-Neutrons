
# This class contains the methods to initialize and create a player, as well as change their score
class Player
  # player information
  attr_reader :name, :score

  # create the player
  def initialize
    @name = ''
    @score = 0
  end

  # asks for and sets a name for a player
  # Params
  # player - The specified player to be named
  def name_player(player)
    print 'Enter the name for ' + player + ': '
    @name = gets.chomp
  end

  # functions that increase the players score by three
  def increase_points
    @score += 3
  end

  # function that decreases the players score by whatever value is inputted
  # Params
  # value - The number of points to deduct from the player score
  def decrease_points(value)
    @score -= value
  end
end
