module Haulable
  def haul(weight)
    weight < 5000 ? (puts "You can haul it.") : (puts "It's too heavy to haul.")
  end
end

class Vehicle
  attr_reader :year, :model
  attr_accessor :color

  @@vehicle_number = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@vehicle_number += 1
  end

  def self.mileage(gallons, miles)
    puts "Your mileage is #{miles/gallons} miles per gallon of gas."
  end

  def self.total_number_of_vehicles
    puts "You have #{@@vehicle_number} vehicles."
  end

  def spray_paint(color)
    @color = color
    puts "The new #{color} color looks awesome!"
  end

  def current_speed
    puts "You are now going #{@speed} mph."
  end

  def speed_up(num)
    @speed += num
    puts "You hit the gas and accelerate #{num} mph."
  end

  def brake(num)
    @speed -= num
    puts "You hit the brake and decelerate #{num} mph."
  end

  def shut_off
    @speed = 0
    puts "You are now parked."
  end

  def age
    puts "Your vehicle is #{how_old} years old."
  end

  private

  def how_old
    year = Time.now.year
    year - @year
  end

end

class MyTruck < Vehicle
  TYPE = :truck
  include Haulable
  def to_s
    "My truck is a #{@color}, #{@year} #{@model}."
  end
end

class MyCar < Vehicle
  TYPE = :car

  def to_s
    "My car is a #{@color}, #{@year} #{@model}."
  end
end

fj = MyTruck.new(2007, 'yellow', 'toyota FJ cruiser')
subie = MyCar.new(2011, 'red', 'subaru crosstrek')
puts fj
puts subie
subie.spray_paint("green")

MyCar.mileage(13, 200)
Vehicle.total_number_of_vehicles
fj.haul(50000)

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

fj.age
