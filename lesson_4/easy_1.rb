# Question 1
# Which of the following are objects in Ruby? If they are objects, how can you
# find out what class they belong to?
#    true
#    "hello"
#    [1, 2, 3, "happy days"]
#    142
# Answer: All of them are objects! a is from the TrueClass, b is class String
#   c is class Array, and d is class Integer
# You can find this out using the Object#class method

# Question 2
# If we have a Car class and a Truck class and we want to be able to go_fast,
# how can we add the ability for them to go_fast using the module Speed? How can
# you check if your Car or Truck can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

puts Car.new.go_fast
puts Truck.new.go_fast

# Question 3
# When we called the go_fast method from an instance of the Car class above,
# you might have noticed that the string printed when we go fast includes
# the name of the type of vehicle we are using. How is this done?

# Anwer: self.class refers to the type of class the object that is calling the
#   go_fast method is. It is then able to interpolate the class name into the
#   string

# Question 4
# If we have a class AngryCat how do we create a new instance of this class?

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

AngryCat.new

# Question 5
# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Answer: class Pizza has an intance variable as indicated with the preceeding
#    '@` in front of @name

# Question 6
# # What could we add to the class below to access the instance variable @volume?

class Cube
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end
end

# Question 7
# What is the default return value of to_s when invoked on an object? Where
# could you go to find out if you want to be sure?

# Answer: The to_s method returns the name of the object's class and an encoding
  # of the object ID. Answer is in the OOP LS book.

# Question 8
# What does self refer to below?
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# Answer: It refers to the instance (object) calling the method.

# Question 9
# What does self refer to in this context?
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

# Answer: self here refers to the class itself, Cat.

# Question 10
# If we have the class below, what would you need to call to create a new
# instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

Bag.new('black', 'leather')

