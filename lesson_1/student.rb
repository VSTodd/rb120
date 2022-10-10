class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    self.grade > other.grade
  end

  protected

  attr_reader :grade

end

veronika = Student.new("Veronika", 90)
rebecca = Student.new("Rebecca", 95)

puts "Well done!" if rebecca.better_grade_than?(veronika)