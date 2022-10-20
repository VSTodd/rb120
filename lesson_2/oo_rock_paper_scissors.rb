module Displayable
  def prompt(msg)
    puts ">> #{msg}"
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  private

  def to_s
    @value
  end

  def initialize(value)
    @value = value
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.lizard? || other_move.paper?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end
end

class Spock < Move
  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Player
  include Displayable

  attr_accessor :move, :name

  private

  def initialize
    set_name
  end

  def selection(choice)
    case choice
    when 'rock' then Rock.new(choice)
    when 'paper' then Paper.new(choice)
    when 'scissors' then Scissors.new(choice)
    when 'lizard' then Lizard.new(choice)
    when 'spock' then Spock.new(choice)
    end
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      prompt "Choose rock(r), paper(p), scissors(sc), lizard(l), or spock(sp):"
      choice = gets.chomp
      choice = finish_choice(choice)
      break if Move::VALUES.include? choice
      prompt "Sorry, that choice is invalid."
    end
    self.move = selection(choice)
  end

  private

  def set_name
    n = ''
    loop do
      prompt "Please enter your name:"
      n = gets.chomp.strip
      break unless n.empty?
      prompt "Sorry, must enter a value."
    end
    self.name = n.capitalize
  end

  def finish_choice(string)
    return 'rock' if string.downcase.start_with?('r')
    return 'paper' if string.downcase.start_with?('p')
    return 'scissors' if string.downcase.start_with?('sc')
    return 'lizard' if string.downcase.start_with?('l')
    return 'spock' if string.downcase.start_with?('sp')
    string
  end
end

class Computer < Player
  def choose(other_move)
    case name
    when 'BB-8' then self.move = selection(Move::VALUES[0..-2].sample)
      # never chooses spock
    when 'Karen'
      # cheats 50% of the time
      cheat(other_move)
    when 'Compy 386' then self.move = selection(Move::VALUES.sample)
      # randomly selects move
    when 'J.A.R.V.I.S.' then self.move = select_winner(other_move)
      # always wins because of special analysis...or something
    when 'BMO' then self.move = select_loser(other_move)
      # always lets you win (so you keep playing with them)
    end
  end

  private

  def set_name
    self.name = ['BB-8', 'Karen', 'Compy 386', 'J.A.R.V.I.S.', 'BMO'].sample
  end

  def select_winner(other_move)
    move = nil
    loop do
      move = selection(Move::VALUES.sample)
      break if move > other_move
    end
    move
  end

  def select_loser(other_move)
    move = nil
    loop do
      move = selection(Move::VALUES.sample)
      break if other_move > move
    end
    move
  end

  def cheat(other_move)
    self.move = if [true, false].sample
                  select_winner(other_move)
                else
                  selection(Move::VALUES.sample)
                end
  end
end

# Game Orchestration Engine
class RPSGame
  include Displayable

  attr_accessor :human, :computer

  @@tracker = []

  def play
    display_welcome_message
    instructions
    continue
    match_loop
    display_goodbye_message
  end

  private

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def round_loop
    loop do
      human.choose
      computer.choose(human.move)
      display_moves
      round_winner
      log_moves
      display_score
      print_history
      break if game_over?
    end
  end

  def match_loop
    loop do
      @@human_score = 0
      @@computer_score = 0
      @@tracker = []
      opponent
      round_loop
      display_winner
      @computer = Computer.new
      break unless play_again?
    end
  end

  # rubocop:disable Metrics/MethodLength
  def display_welcome_message
    system 'clear'
    puts '______           _       ______'
    puts '| ___ \         | |      | ___ \ '
    puts '| |_/ /___   ___| | __   | |_/ /_ _ _ __   ___ _ __   '
    puts '|    // _ \ / __| |/ /   |  __/ _` |  _ \ / _ \  __|  '
    puts '| |\ \ (_) | (__|   < _  | | | (_| | |_) |  __/ |_     '
    puts '\_| \_\___/ \___|_|\_( ) \_|  \__,_| .__/ \___|_( ) '
    puts ' _____      _        |/            | |          |/  '
    puts '/  ___|    (_)                     |_|              '
    puts '\ `--.  ___ _ ___ ___  ___  _ __ ___    '
    puts ' `--. \/ __| / __/ __|/ _ \|  __/ __| '
    puts '/\__/ / (__| \__ \__ \ (_) | |  \__ \ '
    puts '\____/ \___|_|___/___/\___/|_|  |___/ '
    puts "\n"
    puts '                                    (+ Lizard, Spock)'
    puts "\n"
  end
  # rubocop:enable Metrics/MethodLength

  def instructions
    puts "The following game is a variation on 'Rock, Paper, Scissors', adding"
    puts "the options 'Lizard' and 'Spock' to decrease the likelihood of a tie."
    puts "\n"
    prompt 'Rock breaks Scissors and crushes Lizard'
    prompt 'Paper covers Rock and disproves Spock'
    prompt 'Scissors cuts Paper and decapitates Lizard'
    prompt 'Lizard poisons Spock and eats Paper'
    prompt 'Spock smashes Scissors and vaporizes Rock'
    puts "\n"
    prompt 'First player to three wins!'
  end

  def continue
    puts "\n"
    sleep(5)
    prompt('Enter any key to continue:')
    gets.chomp
  end

  def display_goodbye_message
    prompt "Thank you for playing! Goodbye!"
    sleep(5)
  end

  def display_moves
    prompt "#{human.name} chose #{human.move}"
    prompt "#{computer.name} chose #{computer.move}"
  end

  def round_winner
    if human.move > computer.move
      @@human_score += 1
      prompt "#{human.name} won the round!"
    elsif computer.move > human.move
      @@computer_score += 1
      prompt "#{computer.name} won the round!"
    else
      prompt "It's a tie!"
    end
  end

  def display_winner
    if @@human_score > @@computer_score
      prompt "Congratulations #{human.name}, you won the game!"
    else
      prompt "Sorry #{human.name}, #{computer.name} won the game!"
    end
  end

  def display_score
    sleep(5)
    system 'clear'
    puts "The score is:"
    puts "#{human.name}: #{@@human_score}"
    puts "#{computer.name}: #{@@computer_score}"
    puts "\n"
  end

  def game_over?
    @@human_score == 3 || @@computer_score == 3
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      answer = gets.chomp
      answer = answer[0]
      break if ['y', 'n'].include? answer.downcase
      prompt "Please enter 'y' or 'n'."
    end

    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'
  end

  def log_moves
    @@tracker << [human.move, computer.move]
  end

  def print_history
    play1 = human.name
    play2 = computer.name
    puts "Current move history:"
    @@tracker.each_with_index do |arr, index|
      num = index + 1
      puts "##{num}: #{play1} chose #{arr[0]}, #{play2} chose #{arr[1]}"
    end
    puts "\n"
  end

  def opponent
    system 'clear'
    prompt "Your opponent is #{computer.name}"
    sleep(3)
  end
end

RPSGame.new.play
