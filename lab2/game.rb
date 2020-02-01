require_relative 'deck'
require_relative 'multi_player'

class Game < Array
  def initialize
    @deck = Deck.new
    @draw_pile = @deck.cards
    @board = @draw_pile.shift(12)
    @active_player = nil
    @players = MultiPlayer.new(2)
    @quit = false
    @is_first_time = true
    @hint_type_one = false
    @hint_type_two = false
  end

  # returns the size of the board.  The board will only be less than 12 when the draw pile is empty.
  def cards_left
    @board.length
  end

  # starts a round.
  def deal
    check_matches
    return if @quit

    if @is_first_time
      @players.name_all_players
      @active_player = @players.determine_starting_player
      @is_first_time = false
    end

    @deck.print_cards @board
    next_move
  end

  # makes sure that there is at least one match on the board.
  def check_matches
    return unless find_matches.empty?

    all_cards_left = @board + @draw_pile
    if find_matches(all_cards_left).length.zero?
      puts 'There are no more matches in the whole deck!'
      game_over
    else
      swap_three
    end
  end

  # finds all of the matches on the board and returns an array of them.  Could be used to give another hint.
  def find_matches(cards = @board)
    cards.combination(3).to_a.select { |group| a_set? group }
  end

  # after printing the board, asks what the player would like to do.
  def next_move
    ask_question
    answer = gets.to_i
    until answer.between?(1, 4)
      print 'Try again. Choose 1, 2, 3 or 4: '
      answer = gets.to_i
    end
    find_a_set if answer == 1
    give_hint if answer == 2
    @board.shuffle! if answer == 3
    game_over if answer == 4
  end

  # separating the text to make the next_move method shorter
  def ask_question
    print "\n#{@active_player.name}, what would you like to do?"
    puts ' '
    puts '1. Pick a set.'
    puts '2. Get a hint.'
    puts '3. Shuffle the board.'
    puts '4. End Game'
    print 'Choose 1, 2, 3 or 4: '
  end

  # steps for player to select three cards and check if it is a set
  def find_a_set
    puts ''
    cards = pick_a_set
    if a_set? cards
      @board.reject! { |c| cards.include?(c) }
      three_more unless @draw_pile.length.zero?
      up_score
    else
      try_again
    end
  end

  # player picking three cards
  def pick_a_set
    cards = []
    (1..3).each do |i|
      print "Choose card #{i}: "
      answer = gets.to_i
      until answer.between?(1, @board.length) && !cards.include?(@board[answer - 1])
        puts "Try again! Choose card #{i}: "
        answer = gets.to_i
      end
      cards << @board[answer - 1]
    end
    cards
  end

  # determining if the three cards are a set
  def a_set?(three_cards)
    card_strings = []
    for i in 0..2 do
      card_strings[i] = (three_cards[i])[4..10]
      three_cards[i] = (three_cards[i])[0..3]
    end
    bool = three_cards.transpose.all? { |feature| feature.length == 3 && feature.uniq.length != 2 }
    for i in 0..2 do
      (three_cards[i])[4..10] = card_strings[i]
    end
    bool
  end

  # drawing three cards from the draw pile and adding them to the board
  def three_more
    3.times { @board << @draw_pile.shift(1).flatten}
  end

  # response after selecting a correct set
  def up_score

    # modify player score if a hint was used
    @active_player.decrease_points(1) if @hint_type_one
    @active_player.decrease_points(2) if @hint_type_two

    @active_player.increase_points
    puts "\nGreat Job!"
    puts "#{@active_player.name}: your score is now #{@active_player.score}, and there are #{@draw_pile.length} cards left in the draw pile."
    @active_player = @players.switch_players

    @hint_type_one = false
    @hint_type_two= false
    next_move
  end

  # response after selecting an incorrect set
  def try_again
    @active_player.decrease_points(1)
    puts 'Wrong! Lost your turn!'
    puts "#{@active_player.name}: your score is now #{@active_player.score}!"
    puts ' '
    @hint_type_one = false
    @hint_type_two = false
    @active_player = @players.switch_players
    next_move
  end

  # response after asking for a hint.  Gives the number of hints on the board.
  # Could be changed to give one card that is included in a set or something.
  def give_hint
    matches = find_matches.length
    @deck.print_cards @board
    card = find_matches.first.first
    card_index = @board.find_index(card) + 1

    # Display the hint options
    puts "\nHint Types:"
    puts "1. Show number of matching sets (-1 point)"
    puts "2. Show one card that belongs to a set (-2 points)"
    puts "3. Go back"
    print "Choose what kind of hint you want: "

    answer = gets.to_i
    until answer.between?(1, 3)
      print 'Try again. Choose 1 or 2 for a hint or 3 to go back: '
      answer = gets.to_i
    end
    if answer == 1
      puts "\nHint: There #{matches == 1 ? 'is 1 matching set' : "are #{matches} matching sets"}. " 
      @hint_type_one = true
    elsif answer == 2
      puts "\nHint: Card #{card_index} belongs to a set. "
      @hint_type_two = true
    elsif answer == 3
      # Go back to the main options menu if a user doesn't want a hint
      next_move
    end

    puts ''
    next_move
  end

  # response when game is over, either because there are no more matches
  # or the player ends the game
  def game_over
    @players.print_scores_and_determine_winner
    puts 'Goodbye!!'
    @quit = true
  end

  # swapping the last three cards on the board for new cards from the draw pile
  # so that there is at least one match on the board
  def swap_three
    swap = @board.pop(3)
    three_more
    3.times { @draw_pile << swap.shift(1).flatten }
    @draw_pile.shuffle!
  end

  # boolean keeping track of the player wanting to quit the game.
  def over?
    @quit
  end

  # option to shorten the game, using to test how the game ends.
  # Parameter is the number of cards to take out of the draw pile. 0-69
  def shorten_game(number)
    @draw_pile.shift(number)
  end

end
