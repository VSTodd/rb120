# Privacy

# Modify this class so both flip_switch and the setter method switch= are
# private methods.

# Add a private getter for @switch to the Machine class, and add a method to
# Machine that shows how to use that getter.

class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def display_switch
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
machine.start
puts machine.display_switch

# Fixed Array
# A fixed-length array is an array that always has a fixed number of elements.
# Write a class that implements a fixed-length array, and provides the necessary
# methods to support the following code:

class FixedArray
  attr_accessor :array
  attr_reader :length
  def initialize(length)
    @array = Array.new(length)
    @length = length
  end

  def [](index)
    valid_index?(index)
    array[index]
  end

  def []=(index, object)
    valid_index?(index)
    array[index] = object
  end

  def to_a
    array.clone
  end

  def to_s
    to_a.to_s
  end

  def valid_index?(index)
    raise IndexError unless index < length
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# Students
# Below we have 3 classes: Student, Graduate, and Undergraduate. The
# implementation details for the #initialize methods in Graduate and
# Undergraduate are missing. Fill in those missing details so that the following
# requirements are fulfilled:
  # Graduate students have the option to use on-campus parking, while
    # Undergraduate students do not.
  # Graduate and Undergraduate students both have a name and year associated
    # with them.

# Note, you can do this by adding or altering no more than 5 lines of code.

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end


# Circular Queue
# Your task is to write a CircularQueue class that implements a circular queue
# for arbitrary objects. The class should obtain the buffer size with an
# argument provided to CircularQueue::new, and should provide the following
# methods:
    #enqueue to add an object to the queue
    #dequeue to remove (and return) the oldest object in the queue.
      #It should return nil if the queue is empty.

# You may assume that none of the values stored in the queue are nil (however,
# nil may be used to designate empty spots in the buffer).

class CircularQueue
  attr_accessor :collection
  @@history = 1

  def initialize(size)
    @collection = []
    size.times do
      @collection << Item.new(nil, @@history)
      @@history += 1
    end
  end

  def enqueue(item)
    index = nil
    if openings?
      index = find_opening
    else
      index = find_oldest_index
    end
    @collection[index] = Item.new(item, @@history)
    @@history += 1
  end

  def dequeue
    index = find_oldest_value
    removed = collection[index].value
    @collection[index] = Item.new(nil, @@history) unless removed == nil
    @@history += 1
    removed
  end

  def values
    collection.map { |item| item.value }
  end

  def ages
    collection.map { |item| item.age }
  end

  def find_oldest_index
    oldest = @@history
    index = nil
    ages.each_with_index do |age, idx|
      if oldest >= age
        oldest = age
        index = idx
      end
    end
    index
  end

  def find_oldest_value
    oldest = @@history
    index = 0
    self.ages.each_with_index do |age, idx|
      if age < oldest && self.values[idx] != nil
        oldest = age
        index = idx
      end
    end
    index
  end

  def openings?
    values.include? nil
  end

  def find_opening
    index = nil
    options = []
    values.each_with_index { |value, idx| options << idx if value == nil }
    options.each { |idx| index = idx if index == nil || ages[index] > ages[idx] }
    index
  end
end

class Item
  attr_reader :value, :age
  def initialize(value, age)
    @value = value
    @age = age
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

# Stack Machine Interpretation
# Write a class that implements a miniature stack-and-register-based programming
# language that has the following commands:
  # n Place a value n in the "register". Do not modify the stack.
  # PUSH Push the register value on to the stack. Leave the value in the register.
  # ADD Pops a value from the stack and adds it to the register value, storing
    # the result in the register.
  # SUB Pops a value from the stack and subtracts it from the register value,
    # storing the result in the register.
  # MULT Pops a value from the stack and multiplies it by the register value,
    # storing the result in the register.
  # DIV Pops a value from the stack and divides it into the register value,
    # storing the integer result in the register.
  # MOD Pops a value from the stack and divides it into the register value,
    # storing the integer remainder of the division in the register.
  # POP Remove the topmost item from the stack and place in register
  # PRINT Print the register value
  # All operations are integer operations (which is only important with DIV and MOD).

  # Programs will be supplied to your language method via a string passed in as
  # an argument. Your program should produce an error if an unexpected item is
  # present in the string, or if a required stack value is not on the stack when
  # it should be (the stack is empty). In all error cases, no further processing
  # should be performed on the program.

  # You should initialize the register to 0.
class MinilangError < StandardError; end

class InvalidTokenError < MinilangError; end

class EmptyStackError < MinilangError; end

class Minilang
  attr_accessor :commands, :stack, :register

  def initialize(commands)
    @register = 0
    @stack = []
    @commands = commands.split(' ').map! do |command|
                  command.to_i.to_s == command ? command.to_i : command
                end
  end

  def eval
    commands.each do |command|
      case command
      when -100..100 then update_register(command.to_i)
      when 'PUSH' then push
      when 'ADD' then add
      when 'SUB' then sub
      when 'MULT' then mult
      when 'DIV' then div
      when 'MOD' then mod
      when 'POP' then pop
      when 'PRINT' then print
      else raise InvalidTokenError, "Invalid token: #{command}"
      end
    end
  rescue MinilangError => error
    puts error.message
  end

  def update_register(num)
    @register = num
  end

  def push
    stack << register
  end

  def add
    @register = register + stack.pop
  end

  def sub
    @register = register - stack.pop
  end

  def mult
    @register = register * stack.pop
  end

  def div
    @register = register / stack.pop
  end

  def mod
    @register = register % stack.pop
  end

  def pop
    @register = stack.pop
    raise EmptyStackError, "Empty Stack!" if @register == nil
  end

  def print
    puts register
  end

end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# Number Guesser Part 1
# Create an object-oriented number guessing class for numbers in the range 1 to
# 100, with a limit of 7 guesses per game.

class GuessingGame
  attr_reader :num
  attr_accessor :guesses, :entry
  MAX_GUESSES = 7
  RANGE = 1..100

  def initialize
    @num = RANGE.to_a.sample
    @guesses = MAX_GUESSES
    @entry = nil
  end

  def play
    loop do
      guesses_message
      enter_number
      @guesses -= 1
      evaluate_number
      break if won || guesses_left
      puts ""
    end
  end

  private

  def enter_number
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      @entry = gets.chomp.to_i
      break if RANGE.cover?(entry)
      puts "Invalid Entry"
    end
  end

  def guesses_message
    if guesses >= 2
      puts "You have #{guesses} guesses remaining."
    else
      puts "You have #{guesses} guess remaining."
    end
  end

  def evaluate_number
    if entry > num
      puts "Your guess is too high."
    elsif entry < num
      puts "Your guess is too low."
    else
      puts "That's the number!"
      puts ""
      puts "You won!"
    end
  end

  def won
    entry == num
  end

  def guesses_left
    if guesses <= 0
      puts "You have no more guesses. You lost!"
      true
    else
      false
    end
  end
end

game = GuessingGame.new
game.play

# Number Guesser Part 2
# Update your number guesser to accept a low and high value when you create a
# GuessingGame object, and use those values to compute a secret number for the
# game. You should also change the number of guesses allowed so the user can
# always win if she uses a good strategy. You can compute the number of guesses
# with: Math.log2(size_of_range).to_i + 1

class GuessingGame
  attr_reader :num, :range
  attr_accessor :guesses, :entry

  def initialize(range_first, range_last)
    @range = range_first..range_last
    @num = @range.to_a.sample
    @guesses = Math.log2(size_of_range).to_i + 1
    @entry = nil
  end

  def play
    loop do
      guesses_message
      enter_number
      @guesses -= 1
      evaluate_number
      break if won || guesses_left
      puts ""
    end
  end

  private

  def size_of_range
    range.last - range.first
  end

  def enter_number
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      @entry = gets.chomp.to_i
      break if range.cover?(entry)
      puts "Invalid Entry"
    end
  end

  def guesses_message
    if guesses >= 2
      puts "You have #{guesses} guesses remaining."
    else
      puts "You have #{guesses} guess remaining."
    end
  end

  def evaluate_number
    if entry > num
      puts "Your guess is too high."
    elsif entry < num
      puts "Your guess is too low."
    else
      puts "That's the number!"
      puts ""
      puts "You won!"
    end
  end

  def won
    entry == num
  end

  def guesses_left
    if guesses <= 0
      puts "You have no more guesses. You lost!"
      true
    else
      false
    end
  end
end


game = GuessingGame.new(0, 2000)
game.play

# Poker!
# In the previous two exercises, you developed a Card class and a Deck class.
# You are now going to use those classes to create and evaluate poker hands.

class Deck
  attr_accessor :cards
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = nil
    shuffle
  end

  def shuffle
    @cards = RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
    @cards.shuffle!
  end

  def draw
    shuffle if cards.empty?
    @cards.pop
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value
  end

  def value
    case rank
    when (2..10) then rank
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class PokerHand
  def initialize(deck)
    @deck = deck
    @hand = []
    5.times { @hand << deck.draw }
  end

  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def ranks
    @hand.map { |card| card.rank }
  end

  def suits
    @hand.map { |card| card.suit }
  end

  def values
    @hand.map { |card| card.value }
  end


  def royal_flush?
    straight_flush? && (values.sort[4] == 14)
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    of_a_kind(4, 1)
  end

  def full_house?
    ranks.uniq.length == 2
  end

  def flush?
    suits.uniq.length == 1
  end

  def straight?
    sorted_hand = values.sort
    sorted_hand.each_index do |index|
      unless index == 4
        return false if sorted_hand[index + 1] - sorted_hand[index] != 1
      end
    end
    true
  end

  def three_of_a_kind?
    of_a_kind(3, 1)
  end

  def two_pair?
    of_a_kind(2, 2)
  end

  def pair?
    of_a_kind(2, 1)
  end

  def of_a_kind(kind, sets)
    pairs = 0
    ranks.each { |card| pairs += 1 if ranks.count(card) == kind }
    return true if pairs / kind == sets
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
