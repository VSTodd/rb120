class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

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

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?) ||
      (rock? && other_move.lizard?) ||
      (lizard? && other_move.spock?) ||
      (spock? && other_move.scissors?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.paper?) ||
      (paper? && other_move.spock?) ||
      (spock? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, that choice is invalid."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['BB-8', 'Karen', 'Compy', 'J.A.R.V.I.S.', 'BMO'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def round_winner
    if human.move > computer.move
      @@human_score += 1
      puts "#{human.name} won the round!"
    elsif computer.move > human.move
      @@computer_score += 1
      puts "#{computer.name} won the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_winner
    if @@human_score > @@computer_score
      puts "Congratulations, #{human.name} won the game!"
    else
      puts "Sorry, #{computer.name} won the game."
    end
  end

  def display_score
    sleep(3)
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
      puts "Would you like to play again> (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'
  end

  def play
    display_welcome_message
    sleep (3)
    loop do
      @@human_score = 0
      @@computer_score = 0
      system 'clear'
      loop do
        human.choose
        computer.choose
        display_moves
        round_winner
        display_score
        break if game_over?
      end
      display_winner
      @computer = Computer.new
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
