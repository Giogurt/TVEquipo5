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

# Crear un carro Golf
golf = Car.new(
  brand:        "Volkswagen",
  name:         "Golf",
  tires:        "Continental",
  motor:        "Turbo 2.5",
  transmission:  "Manual",
  doors:        5,
  style:        "Hashback"
)

# Crear un carro Beetle
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
def calcular_total(carro)
  if carro.name == "Golf"
    tires = Integer(Inventory.continental_tires).to_i/4
    motor = Inventory.motors_with_turbo
    transmission = Inventory.manual_transmissions
    doors = Inventory.doors/carro.doors
  else
    tires = Integer(Inventory.michelin_tires)/4
    motor = Inventory.motors_with_no_turbo
    transmission = Inventory.automatic_transmissions
    doors = Inventory.doors/carro.doors
  end
  cantidad = [tires, motor, transmission, doors].min
  cantidad
end
#Guardar el total de carros que podemos fabricar
total = calcular_total(golf)
#Genera el arreglo del carro especificado
arreglo_carros = Array.new(total, golf)

# Post result to validator
result = Transport.post_result(
  team:       5,
  total:      total,
  cars:       arreglo_carros
)

puts result.body.inspect
