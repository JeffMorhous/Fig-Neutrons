class Player
  # player information
  attr_reader :name, :score

  # create the player
  def initialize(name)
    @name = name
    @score = 0
  end

  #function to switch which player
  def switch_player(players, active)
    if (active.name == players[0].name)
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