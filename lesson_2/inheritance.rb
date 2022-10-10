#1. Create a sub-class from Dog called Bulldog overriding the swim method to
# return "can't swim!"

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

frank = Bulldog.new
puts frank.speak
puts frank.swim

#2 Create a new class called Cat, which can do everything a dog can, except swim
# or fetch. Assume the methods do the exact same thing.


class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

end

class Dog < Animal
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

hudson = Dog.new
puts hudson.swim
macy = Cat.new
puts macy.speak