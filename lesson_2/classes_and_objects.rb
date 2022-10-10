#1: Given the below usage of the Person class, code the class definition.
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'

#2: Modify the class definition from above to facilitate the following methods.
# Note that there is no name= setter method now.

class Person
  attr_accessor :first_name, :last_name
  def initialize(first, last='')
    @first_name = first
    @last_name = last
  end

  def name
    last_name == '' ? @first_name : (@first_name + ' ' + @last_name)
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

#3: Now create a smart name= method that can take just a first name or a full
# name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name
  def initialize(first, last='')
    @first_name = first
    @last_name = last
  end

  def name
    last_name == '' ? @first_name : (@first_name + ' ' + @last_name)
  end

  def name=(n)
    if n.split.length > 1
      @first_name = n.split[0]
      @last_name = n.split(' ')[1]
    else
      @first_name = n
      @last_name = ''
    end
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'

#4: If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

bob.name == rob.name
