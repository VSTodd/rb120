# Question 1
# If we have this code:
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
# What happens in each of the following cases:
#1a
hello = Hello.new
hello.hi # => "Hello"

#1b
hello = Hello.new
hello.bye # => NoMethodError

#1c
hello = Hello.new
hello.greet #=> ArgumentError

#1d
hello = Hello.new
hello.greet("Goodbye") # => Goodbye

#1e
Hello.hi #=> NoMethodError

# Question 2
# If we call Hello.hi we get an error message. How would you fix this?
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi

# Question 3
# Given the class below, how do we create two different instances of this class
# with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

macy = AngryCat.new(10, 'Macy')
nori = AngryCat.new(5, 'Nori')

# Question 4
# How could we go about changing the to_s output on this method to look like
# this: I am a tabby cat? (this is assuming that "tabby" is the type we passed
# in during initialization).

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat."
  end
end

macy = Cat.new('calico')

# Question 5
# What would happen if I called the methods like shown below?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # => NoMethodError
tv.model # => the method logic

Television.manufacturer # => the method logic
Television.model # => NoMethodError

# Question 6
# In the make_one_year_older method we have used self. What is another way we
# could write this method so we don't have to use the self prefix?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

macy = Cat.new('calico')
macy.make_one_year_older
puts macy.age

# Question 7
# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end


