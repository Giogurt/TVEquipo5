require 'car_factory'

include CarFactory
#cambio
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
# car = Car.new(
#   brand:        "Mercedes",
#   name:         "Citan",
#   tires:        "Continental",
#   motor:        "Turbo 2.5",
#   transmission: "Manual",
#   doors:        2,
#   style:        "Sedan"
# )

# Crear un carro Golf
golf = Car.new(
  brand:        "Volkswagen",
  name:         "Golf",
  tires:        "Continental",
  motor:        "Turbo 2.5",
  transmision:  "Manual",
  doors:        5,
  style:        "Hashback"
)

# Crear un carro Beatle
beetle = Car.new(
  brand:        "Volkswagen",
  name:         "Beetle",
  tires:        "Michelin",
  motor:        "Non Turbo 2.0",
  transmission: "Automatic",
  doors:        4,
  style:        "Sedan"
)

# Metodo que calcula la cantidad de carros que se pueden crear
def calcular(carro)
  if carro.name = "Golf"
    tires = Inventory.continental_tires/carro.tires
    motor = Inventory.motors_with_turbo
    transmision = Inventory.manual_transmissions
    doors = Inventory.doors/carro.doors
  else
    tires = Inventory.michelin_tires/carro.tires
    motor = Inventory.motors_with_no_turbo
    transmision = Inventory.automatic_transmissions
    doors = Inventory.doors/carro.doors
  end
  cantidad = [tires, motor, transmision, doors].min
  puts cantidad
  return cantidad
end

# Metodo que crea un arreglo de multiples copias de un mismo carro
def crearCarro(carro,cantidad)
  arrCarro = []
  i = 0
  loop do
    arrCarro.push(carro)
    i++
    if i == cantidad
      break
    end
  end
  return arrCarro
end

# Post result to validator
result = Transport.post_result(
  team:       5,
  total:      calcular(golf),
  cars:       [crearCarro(golf,calcular(golf))]
)

puts result.body.inspect
