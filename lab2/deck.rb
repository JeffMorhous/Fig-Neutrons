require 'colorize'

class Deck < Array

  # allow @cards to be read
  attr_reader :cards

  #Initializes a deck of cards with a "card" for each possible combination of colors, fills, shapes and 
  #numbers that can be put on a card and its graphical output in form of an 11 element array 
  def initialize
    colors = %w[blue red green]
    shapes = %w[square tri circle]
    fill = %w[filled half open]
    number = [1, 2, 3]
    color_and_shape = colors.product(shapes)
    fill_and_number = fill.product(number)
    @cards = color_and_shape.product(fill_and_number).map(&:flatten).shuffle!
    @cards.each { |card| shape_strings!(card) }
  end

  #Prints out the given cards (|cards| <= 12)
  #
  #Params: 
  #cards - an array of 1 - 12 "cards" which are arrays holding color, shape, fill
  #        and number along with 7 strings to represent the graphical output of the card

  def print_cards(cards)
    puts '  '
    card_num = 0
    # calculate how many rows are needed to display all the cards
    rows = 1
    rows += 1 if cards.length > 6

    (1..rows).each do |row|
      # header for each card that displays card number
      puts "  Card #{card_num + 1}:      Card #{card_num + 2}:      Card #{card_num + 3}:      Card #{card_num + 4}:      Card #{card_num + 5}:      Card #{card_num + 6}:"

      # loop through each line of the cards to print them in one row
      (0..6).each do |line|
        # keep track of which of the twelve cards are being printed
        i = card_num
        details = []

        # calculates how many cards to print out on last row just in case six are not left
        cards_to_print = row == rows ? ((cards.length-1) % 6) + 1 : 6

        # push the current line of each card in the row to details
        cards_to_print.times do
          details.push((cards[i])[4 + line])
          i += 1
        end

        # print out the current line of all cards in the row
        puts '  ' + details.join('      ') + '  '
      end

      # increment card count
      card_num += 6
    end
  end

  #Adds the graphical representation of a card via strings for each line of the card to the 
  #end of the givecn card array
  #
  #Params: 
  #card - card array with the first four elements representing the cards color, 
  #       shape, fill, and number respectivly
  def shape_strings!(card)
    # store basic values from the card
    shape = card[1]
    fill = card[2]
    number = card[3]
    color = card[0]

    # set up unicode values for the different shapes
    shapes1 = { filled_circle: "\u25CF".encode('utf-8'),
                half_circle: "\u25D0".encode('utf-8'),
                open_circle: "\u25CB".encode('utf-8'),
                filled_tri: "\u25B2".encode('utf-8'),
                half_tri: "\u25ED".encode('utf-8'),
                open_tri: "\u25B3".encode('utf-8'),
                filled_square: "\u25A0".encode('utf-8'),
                half_square: "\u25E7".encode('utf-8'),
                open_square: "\u25A1".encode('utf-8') }

    # set up the different lines for the card display based off initial card values             
    card[4] = "\xE2\x96\x81\xE2\x96\x81\xE2\x96\x81\xE2\x96\x81\xE2\x96\x81\xE2\x96\x81\xE2\x96\x81"
    card[5] = '|=====|'.colorize(:black).colorize(background: color.to_sym)
    if number == 2 || number == 3
      card[6] = ('|| ' +shapes1["#{fill}_#{shape}".to_sym]+ ' ||').colorize(:black).colorize(background: color.to_sym)
      card[8] = ('|| ' +shapes1["#{fill}_#{shape}".to_sym]+ ' ||').colorize(:black).colorize(background: color.to_sym)
    else
      card[6] = '||   ||'.colorize(:black).colorize(background: color.to_sym)
      card[8] = '||   ||'.colorize(:black).colorize(background: color.to_sym)
    end
    if number == 3 || number == 1
      card[7] = ('|| ' +shapes1["#{fill}_#{shape}".to_sym]+ ' ||').colorize(:black).colorize(background: color.to_sym)
    else
      card[7] = '||   ||'.colorize(:black).colorize(background: color.to_sym)
    end

    card[9] = '|=====|'.colorize(:black).colorize(background: color.to_sym)
    card[10] = "\xE2\x96\x94\xE2\x96\x94\xE2\x96\x94\xE2\x96\x94\xE2\x96\x94\xE2\x96\x94\xE2\x96\x94"
  end

end