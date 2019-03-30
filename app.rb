require 'car_factory'

include CarFactory

# Database connection
Database.load(db_file: 'db.yml')
# Which fields are available
puts "Continental: #{Inventory.continental_tires}"
puts "Michelin #{Inventory.michelin_tires}"
puts "Turbo #{Inventory.motors_with_turbo}"
puts "No turbo #{Inventory.motors_with_no_turbo}"
puts "Doors #{Inventory.doors}"
puts "Manual #{Inventory.manual_transmissions}"
puts "Automatic #{Inventory.automatic_transmissions}"

# Create a Golf car
golf = Car.new(
  brand:        "Volkswagen",
  name:         "Golf",
  tires:        "Continental",
  motor:        "Turbo 2.5",
  transmission:  "Manual",
  doors:        5,
  style:        "Hashback"
)

# Create a Beetle car
beetle = Car.new(
  brand:        "Volkswagen",
  name:         "Beetle",
  tires:        "Michelin",
  motor:        "Non Turbo 2.0",
  transmission: "Automatic",
  doors:        4,
  style:        "Sedan"
)
# Method that calculates the number of cars that can be created
def calculate_total_cars(car)
  if car.name == "Golf"
    tires = Inventory.continental_tires.to_i/4
    motor = Inventory.motors_with_turbo
    transmission = Inventory.manual_transmissions
    doors = Inventory.doors/car.doors
  else
    tires = Inventory.michelin_tires/4
    motor = Inventory.motors_with_no_turbo
    transmission = Inventory.automatic_transmissions
    doors = Inventory.doors/car.doors
  end
  quantity = [tires, motor, transmission, doors].min
end

total = calculate_total_cars(beetle)
array_cars = Array.new(total, beetle)

# Post result to validator
result = Transport.post_result(
  team:       5,
  total:      total,
  cars:       array_cars
)

puts result.body.inspect
