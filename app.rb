require 'car_factory'

include CarFactory

# Database connection
Database.load(db_file: 'db.yml')

# Which fields are available
puts Inventory.continental_tires
puts Inventory.michelin_tires
puts Inventory.motors_with_turbo
puts Inventory.motors_with_no_turbo
puts Inventory.doors
puts Inventory.manual_transmissions
puts Inventory.automatic_transmissions

# How to build a car object
car = Car.new(
  brand:        "Mercedes",
  name:         "Citan",
  tires:        "Continental",
  motor:        "Turbo 2.5",
  transmission: "Manual",
  doors:        2,
  style:        "Sedan"
)

def crearCarro(carro,cantidad)
  arrCarro = []
  i = 0
  loop do
    arrCarro.push(carro)
    i++
    if i == cantidad-1
      break
    end
  end
  return arrCarro
end

# Post result to validator
result = Transport.post_result(
  team:       1,
  total:      1,
  cars:       [car]
)

puts result.body.inspect
