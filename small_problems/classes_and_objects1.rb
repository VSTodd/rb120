# Find the Class
def puts(obj)
  p obj.class
end

puts "Hello"    #=> String
puts 5          #=> Integer
puts [1, 2, 3]  #=> Array

# Create the Class
class Cat
end

# Create the Object
class Cat
end

kitty = Cat.new

#What Are You?
class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new

#Hello Sophie! (Part 1)
class Cat
  def initialize(name)
    @name = name
    puts "Meow! My name is #{@name}."
  end
end

kitty = Cat.new('Sophie')

# Hello, Sophie! (Part 2)
class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Meow! My name is #{@name}."
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# Reader
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Meow! My name is #{name}."
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# Writer
class Cat
  attr_reader :name
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Meow! My name is #{name}."
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet

# Accessor
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Meow! My name is #{name}."
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet

# Walk the Cat!
module Walkable
  def walk
    puts "Lets go for a walk!"
  end
end

class Cat
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Meow! My name is #{name}."
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk