module Formatable
  def join_and(array)
    new_arr = []
    array.each { |element| new_arr << element }
    if new_arr.length == 2
      new_arr[0].to_s + ' and ' + new_arr[1].to_s
    else
      new_arr[-1] = "and #{new_arr.last}"
      new_arr.join(', ')
    end
  end

  def prompt(msg)
    puts ">> #{msg}"
  end

  def hold_prompt(msg)
    puts ">> #{msg}"
    sleep(4)
  end

  def clear
    system 'clear'
  end
end

module Displayable
  POINTS = 3
  def display_welcome_message
    title
    instructions
    continue
  end

  def display_goodbye_message
    prompt "Thank you for playing Twenty-One. Goodbye!"
    sleep(5)
  end

  def display_score
    hold_prompt("The score is player: #{player.score}, dealer: #{dealer.score}")
  end

  def show_round_result
    clear
    view_hand_totals
    hold_prompt(round_winner)
  end

  def round_winner
    if dealer.total > player.total
      "The dealer wins the round!"
    elsif dealer.total < player.total
      "You win the round!"
    else
      "It's a draw!"
    end
  end

  def show_match_result
    clear
    player.score > dealer.score ? won : lost
  end

  # rubocop:disable Layout/LineLength

  def won
    puts '██    ██  ██████  ██    ██     ██     ██  ██████  ███    ██ ██ '
    puts ' ██  ██  ██    ██ ██    ██     ██     ██ ██    ██ ████   ██ ██ '
    puts '  ████   ██    ██ ██    ██     ██  █  ██ ██    ██ ██ ██  ██ ██ '
    puts '   ██    ██    ██ ██    ██     ██ ███ ██ ██    ██ ██  ██ ██    '
    puts '   ██     ██████   ██████       ███ ███   ██████  ██   ████ ██ '
    puts ' '
    prompt 'The player wins the match!'
  end

  def lost
    puts '██    ██  ██████  ██    ██     ██       ██████  ███████ ████████      '
    puts ' ██  ██  ██    ██ ██    ██     ██      ██    ██ ██         ██         '
    puts '  ████   ██    ██ ██    ██     ██      ██    ██ ███████    ██         '
    puts '   ██    ██    ██ ██    ██     ██      ██    ██      ██    ██         '
    puts '   ██     ██████   ██████      ███████  ██████  ███████    ██  ██ ██ ██'
    puts ' '
    prompt 'The dealer wins the match!'
  end

  # rubocop:disable Lint/ImplicitStringConcatenation

  def title
    puts '  _______                 _                 ____             '
    puts ' |__   __|               | |               / __ \            '
    puts '    | |_      _____ _ __ | |_ _   _ ______| |  | |_ __   ___ '
    puts '    | \ \ /\ / / _ \ '' _ \| __| | | |______| |  | | '' _ \ / _ \ '
    puts '    | |\ V  V /  __/ | | | |_| |_| |      | |__| | | | |  __/'
    puts '    |_| \_/\_/ \___|_| |_|\__|\__, |       \____/|_| |_|\___|'
    puts '                               __/ |                         '
    puts '                              |___/                          '
  end

  # rubocop:enable Lint/ImplicitStringConcatenation
  # rubocop:disable Metrics/MethodLength

  def instructions
    prompt "Welcome to Twenty-One!"
    prompt "The goal is to get the total of your hand as close to 21 as possible."
    prompt "If you go over 21, it's a 'bust' and you lose."
    prompt "The card values are as follows:"
    puts "          2 - 10: 	        face value"
    puts "          Jack, Queen, King: 	10"
    puts "          Ace:                  11 unless hand is > 21, then it is 1"
    prompt "You and the dealer are initially dealt 2 cards."
    prompt "You can see both of your cards, but can only see one of the dealer's."
    prompt "You will go first, and can decide to either:"
    puts "    'hit' (draw another card) or 'stay' (move on to the dealer's turn)"
    prompt "The game ends if either player busts or when both players stay."
    prompt "Whoever is closer to 21 wins the round! "
    prompt "Matches will be played until a player reaches #{POINTS} points."
  end

  # rubocop:enable Layout/LineLength
  # rubocop:enable Metrics/MethodLength

  def continue
    sleep(8)
    puts ""
    prompt "Hit enter to continue:"
    gets
    system 'clear'
  end
end

class Participant
  attr_accessor :hand, :score, :total

  include Formatable

  def initialize
    @hand = []
    @score = 0
    @total = 0
  end

  def busted?
    total > Game::END_NUM
  end

  def update_total
    total_num = 0
    hand.each { |card| total_num += card.value }
    hand.select { |card| card.type == 'A' }.count.times do
      total_num -= 10 if total_num > Game::END_NUM
    end
    @total = total_num
  end
end

class Player < Participant
  include Formatable

  def hit?
    answer = nil
    loop do
      prompt "Hit or stay?"
      answer = gets.chomp
      break if answer.downcase.start_with?('s', 'h')
      prompt "Invalid entry."
    end
    answer.downcase.start_with?('h') ? true : false
  end

  def busted_message
    clear
    prompt "You busted with a total of #{total}."
    hold_prompt "Dealer wins the round!"
  end
end

class Dealer < Participant
  def busted_message
    clear
    prompt "The dealer busted with a total of #{total}."
    hold_prompt "Player wins the round!"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::TYPES.each do |type|
        @cards << Card.new(suit, type)
      end
    end
  end

  def hit
    card = cards.sample
    cards.delete(card)
  end
end

class Card
  SUITS = ['♣', '♦', '♥', '♠']
  TYPES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  attr_reader :suit, :type, :value

  def initialize(suit, type)
    @suit = suit
    @type = type
    @value = values(type)
    # what are the "states" of a card?
  end

  def values(type)
    if type.to_s.to_i == type
      type
    elsif type == 'A'
      11
    else
      10
    end
  end

  def to_s
    "#{type}#{suit}"
  end
end

class Game
  END_NUM = 21
  HIT_NUM = 17

  include Formatable, Displayable

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      play_match
      show_match_result
      break unless play_again?
      reset
    end
  end

  def play_match
    loop do
      play_round
      display_score
      break if someone_won?
      shuffle
    end
  end

  def play_round
    deal_cards
    show_cards
    player_turn
    dealer_turn unless player.busted?
    keep_score
    show_round_result unless player.busted? || dealer.busted?
  end

  def deal_cards
    2.times do
      player.hand << deck.hit
      dealer.hand << deck.hit
    end
    player.update_total
    dealer.update_total
  end

  def show_cards
    clear
    puts "Dealer has: an unknown card #{join_and(dealer.hand.drop(1))}."
    puts "You have: #{join_and(player.hand)}, for a total of #{player.total}."
    puts ""
  end

  def player_turn
    loop do
      break unless player.hit?
      draw(player, 'You')
      player.busted_message if player.busted?
      break if player.busted?
    end
  end

  def dealer_turn
    show_cards
    dealer_choice
    dealer.busted_message if dealer.busted?
  end

  def dealer_choice
    loop do
      break if player.busted? || dealer.busted?
      if dealer.total < HIT_NUM
        draw(dealer, 'Dealer')
      elsif dealer.total <= END_NUM
        hold_prompt "The dealer stays."
        break
      end
    end
  end

  def draw(participant, name)
    participant.hand << deck.hit
    hold_prompt "#{name} drew #{participant.hand[-1]}"
    participant.update_total
    show_cards
  end

  def view_hand_totals
    puts ""
    prompt "Dealer has: #{join_and(dealer.hand)}"
    hold_prompt "Dealer total is #{dealer.total}."
    puts ""
    prompt "You have: #{join_and(player.hand)}"
    hold_prompt "Your total is #{player.total}."
    puts ""
  end

  def keep_score
    if player.busted?
      @dealer.score += 1
    elsif dealer.busted?
      @player.score += 1
    elsif @dealer.total != @player.total
      dealer.total > player.total ? dealer.score += 1 : player.score += 1
    end
  end

  def shuffle
    player.hand = []
    dealer.hand = []
    @deck = Deck.new
  end

  def reset
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def someone_won?
    player.score == POINTS || dealer.score == POINTS
  end

  def play_again?
    answer = nil
    loop do
      prompt "Play again? (y or n)"
      answer = gets.chomp.downcase[0]
      break if %w(y n).include? answer
      prompt "Sorry, entry must be y or n"
    end

    answer == 'y'
  end
end

Game.new.start
