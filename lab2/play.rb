require_relative 'deck'
require_relative 'game'

puts ''
puts 'Welcome to Set!'
puts ''
puts 'Rules:'
rules = %(Pick three cards to make a set.  Cards are different in four ways:
color, shape, number of shapes, and how the shapes are filled.
To make a set, the details on the three cards must each be either
all the same or all different. If you guess correctly, you get 3 points.
If you guess incorrectly you lose a point. If you request a hint, you will
lose 1 or 2 points depending on the hint type.  There is no penalty if you 
need to shuffle the board to get a new perspective. You can continue to play 
until there are no matches left, or you can quit at the beginning of any round. Have fun!)
puts rules


this_game = Game.new

# option to shorten the game, using to test how the game ends.
# Parameter is the number of cards to take out of the draw pile,
# use a multiple of three between 3 and 69.

# this_game.shorten_game(30)

this_game.deal while this_game.cards_left.positive? && !this_game.over?

