require 'colorize'

class Deck < Array
  def initialize
    colors = %w[blue red green]
    shapes = %w[square tri circle]
    fill = %w[filled half open]
    number = [1, 2, 3]
    color_and_shape = colors.product(shapes)
    fill_and_number = fill.product(number)
    @cards = color_and_shape.product(fill_and_number).map(&:flatten).shuffle!
  end

  attr_reader :cards

end
