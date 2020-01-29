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
    @cards.each { |card| shape_strings!(card) }
  end

  #prints out the given cards (|cards| <= 12)
  def print_cards(cards) 
    puts '  '
    cardNum = 0
    #calculate how many rows are needed to display all the cards
    rows = 1
    rows +=1 if cards.length() > 6

    for row in 1..rows do
      #header for each card that displays card number
      puts "  Card #{cardNum + 1}:      Card #{cardNum + 2}:      Card #{cardNum + 3}:      Card #{cardNum + 4}:      Card #{cardNum + 5}:      Card #{cardNum + 6}:"
      
      #loop through each line of the cards to print them in one row
      for line in 0..6 do
        #keep track of which of the twelve cards are being printed
        i = cardNum
        details = []

        cardsToPrint = 6;
        #calculates how many cards to print out on last row just incase six are not left
        cardsToPrint = ((cards.length()-1)%6)+1 if (row == rows)  
        
        #push the current line of each card in the row to details
        cardsToPrint.times do
          details.push((cards[i])[4+line])
          i+=1
        end

        #print out the current line of all cards in the row
        puts '  ' + details.join('      ') + '  '
      end

      #increment card count
      cardNum += 6
    end
  end


  def shape_strings!(card)
    #store basic values from the card
    shape = card[1]
    fill = card[2]
    number = card[3]
    color = card[0]

    #set up unicode values for the different shapes
    shapes1 = { filled_circle: "\u25CF".encode('utf-8'),
                 half_circle: "\u25D0".encode('utf-8'),
                 open_circle: "\u25CB".encode('utf-8'),
                 filled_tri: "\u25B2".encode('utf-8'),
                 half_tri: "\u25ED".encode('utf-8'),
                 open_tri: "\u25B3".encode('utf-8'),
                 filled_square: "\u25A0".encode('utf-8'),
                 half_square: "\u25E7".encode('utf-8'),
                 open_square: "\u25A1".encode('utf-8') }

    #set up the different lines for the card display based off initial card values             
    card[4] = "▁▁▁▁▁▁▁"
    card[5] = "|=====|".colorize(:black).colorize(background: color.to_sym)
    if number == 3 || number == 2
      card[6] = ("|| " +shapes1["#{fill}_#{shape}".to_sym]+ " ||").colorize(:black).colorize(background: color.to_sym)
    else
      card[6] = "||   ||".colorize(:black).colorize(background: color.to_sym)
    end
    if number == 3 || number == 1
      card[7] = ("|| " +shapes1["#{fill}_#{shape}".to_sym]+ " ||").colorize(:black).colorize(background: color.to_sym)
    else
      card[7] = "||   ||".colorize(:black).colorize(background: color.to_sym)
    end
    if number == 2 || number == 3
      card[8] = ("|| " +shapes1["#{fill}_#{shape}".to_sym]+ " ||").colorize(:black).colorize(background: color.to_sym)
    else
      card[8] = "||   ||".colorize(:black).colorize(background: color.to_sym)
    end
    card[9] = "|=====|".colorize(:black).colorize(background: color.to_sym)
    card[10] = "▔▔▔▔▔▔▔"
  end

  #allow @cards to be read
  attr_reader :cards

end