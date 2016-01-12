class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss

    set_employees
  end

  def set_employees
    @boss.employees << self if @boss
  end

  def bonus(multiplier)
    if self.is_a?(Manager)
      salary_difference = self.total_salary - @salary
      salary_difference * multiplier
    else
      @salary * multiplier
    end
  end

  def total_salary
    # return @salary if @employees.empty?
    return @salary unless self.is_a?(Manager)

    total = @salary

    @employees.each do |employee|
      total += employee.total_salary
    end

    total
  end


end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss)
    #inherited from Employee class
    ##@name
    ##@title
    ##salary
    ##@boss
    super(name, title, salary, boss)
    @employees = []
  end


end
