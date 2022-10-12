# Fix the Program - Mailable

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new
bob = Employee.new
betty.print_address
bob.print_address

# Fix the Program - Drivable

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# Complete The Program - Houses
class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other_object)
    self.price <=> other_object.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# => Home 1 is cheaper
# => Home 2 is more expensive

# Reverse Engineering
class Transform
  def initialize(data)
    @data = data
  end

  def uppercase
    @data.upcase
  end

  def self.lowercase(data)
    data.downcase
  end
end


my_data = Transform.new('abc')
puts my_data.uppercase          # => 'ABC'
puts Transform.lowercase('XYZ') # => 'xyz'

# What Will This Do?
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata # => 'ByeBye'
puts thing.dupdata # => 'HelloHello'

# Comparing Wallets
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)

if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end


# Pet Shelter
class Pet
  attr_reader :type, :name
  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_reader :name
  attr_accessor :pets, :number_of_pets

  @@owners = []

  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
    @@owners << self
  end

  def self.owners
    @@owners
  end
end

class Shelter
  def adopt(owner, pet)
    owner.pets << pet
    owner.number_of_pets += 1
  end

  def print_adoptions
    Owner.owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet.type} name #{pet.name}"
      end
      puts "\n"
    end
  end
end

# Moving
class Mammal
  def walk
    puts "#{self.name} #{gait} forward"
  end
end

class Person < Mammal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat < Mammal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah < Mammal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

# Nobility
module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def to_s
    name
  end

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def to_s
    name
  end

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def to_s
    name
  end

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title
  include Walkable
  def initialize(name, title)
    @name = name
    @title = title
  end

  private

  def gait
    "struts"
  end

  def to_s
    "#{title} #{name}"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
