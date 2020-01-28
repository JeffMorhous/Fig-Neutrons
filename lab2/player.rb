class Player
  # player information
  attr_reader :name, :score

  # create the player
  def initialize(name)
    @name = name
    @score = score
  end

  # functions that alter the players score
  def increase_points
    @score += 2
  end

  def decrease_points (value)
    @score -= value
  end
end