# Question 1
# What is the result of executing the following code:
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future

# Answer: it will return a string of "You will " followed by a random selection
  # of the array within choices

# Question 2
# What is the result of the following:
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future

# Answer: it will return a string of "You will " followed by a random selection
  # of the array within the choices method of the Roadtrip class

# Question 3
# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?
# What is the lookup chain for Orange and HotSauce?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts Orange.ancestors
puts HotSauce.ancestors

# Answer: You can find the lookup chain for any object by calling the ancestors
#   method on the class. The loopup chain for Orange is Orange -> Taste ->
#   Object -> Kernel -> BasicObject. For Hotsauce it is Hotsauce -> Taste ->
#   Object -> Kernel -> BasicObject.

# Question 4
# What could you add to this class to simplify it and remove two methods from
# the class definition while still maintaining the same functionality?

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# Question 5
# There are a number of variables listed below. What are the different types?

excited_dog = "excited dog"   # => local variable
@excited_dog = "excited dog"  # => instance variable
@@excited_dog = "excited dog" # => class variable

# Question 6
# Which one of these is a class method (if any) and how do you know? How would
# you call a class method?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Answer: self.manufacturer is a class method. You can tell by the self. prefix
#   in the name of the method. You call a class method by replacing self with
# the class name during the method call. Above would be Television.manufacturer.

# Question 7
# Explain what the @@cats_count variable does and how it works. What code would
# you need to write to test your theory?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Answer: The @@cats_count class variable increases by 1 each time a new Cat
  # object is initialized. You can test it, with code similar to below

  Cat.new('calico')
  Cat.new('tabby')
  puts Cat.cats_count # => 2

# Question 8
# What can we add to the Bingo class to allow it to inherit the play method from
# the Game class?

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# Question 9
# What would happen if we added a play method to the Bingo class, keeping in
# mind that there is already a method of this name in the Game class that the
# Bingo class inherits from.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# Answer: The play method in the Bingo class would then override the play method
  # of the Game class for all Bingo objects

# Question 10
# What are the benefits of using Object Oriented Programming in Ruby? Think of
# as many as you can.
	# More organized code
	# Creating objects allows the programmer to think more abstractly about the
	  # code they're writing
	# Reduces repetition in code/easier to reuse pre-written code
	# Objects are represented by nouns so they are easier to conceptualize
	# Easier to manage large, complicated software systems
	# Can change data without having a ripple efect through the entire program
	# Program can be small interacting parts instead of one massive blob of a
	  # program
