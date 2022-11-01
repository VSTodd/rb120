# Question 1
# When Ben asked Alyssa to code review the following code, Alyssa said - "It
# looks fine, except that you forgot to put the @ before balance when you refer
# to the balance instance variable in the body of the positive_balance? method."

# Ben diagrees and thinks its valid...who is right?


class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Answer: Ben is correct, since there is a getter method for @balance established
#   via attr_reader, there is now a method `balance` that returns the value of
#   the @balance instance variable, making the @ unnecessary in the
#   positive_balance? method

# Question 2
# Alyssa looked at the code and spotted a mistake, saying it will fail when
# update_quantity is called. Where is this mistake and how do you address it?

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

# Answer: There is no setter method defined for the @quantity instance variable.
# Define one, perhaps with attr_accessor, for @quantity and then reference like so:
  # self.quantity = updated_count if updated_count >= 0
# OR reference it directly within the update_quantity method, like so:
#   @quantity = updated_count if updated_count >= 0

# Question 3
# Alyssa noticed that this will fail when update_quantity is called. Since
# quantity is an instance variable, it must be accessed with the @quantity
# notation when setting it. One way to fix this is to change attr_reader to
# attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Answer: Yes. There is no reason to have @product_name accessible via setter
#   method. It should be on its own line with an attr_reader, with @quantity
#   being on its own line with attr_accessor. Additionally, you are now allowing
#   users to change the quantity directly (calling the accessor with the
#   instance.quantity = <new value> notation) rather than by going through the
#   update_quantity method, which could cause future problems

# Question 4
# Create a class called Greeting with a single instance method called greet that
# takes a string argument and prints that argument to the terminal.

# Now create two other classes that are derived from Greeting: one called Hello
# and one called Goodbye. The Hello class should have a hi method that takes no
# arguments and prints "Hello". The Goodbye class should have a bye method to
# say "Goodbye". Make use of the Greeting class greet method when implementing
# the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye
# classes.

class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

# Question 5
# Write additional code for KrispyKreme such that the puts statements will work
# as specified above.

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type != nil && @glazing != nil
      "#{@filling_type} with #{@glazing}"
    elsif @filling_type == nil && @glazing != nil
      "Plain with #{@glazing}"
    elsif @filling_type != nil && @glazing == nil
      @filling_type
    else
      "Plain"
    end
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1 # => "Plain"
puts donut2 # => "Vanilla"
puts donut3 # => "Plain with sugar"
puts donut4 # => "Plain with chocolate sprinkles"
puts donut5 # => "Custard with icing"

# Question 6
# What is the difference in the way the code works?
# 1
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

#2
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# With the create_template methods, in the first code snippet is calling the
# @template instance variable directly, whereas the second code snippet is
# calling the template setter method created by the attr_accessor. With the
# show_template methods, they are both accessing the getter method, however as
# code snippet one shows, the self is not necessary

# Question 7
# How could you change the method name below so that the method name is more
# clear and less repetitive?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end



