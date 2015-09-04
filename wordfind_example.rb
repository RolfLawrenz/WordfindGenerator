require_relative 'wordfind_generator'

cars = ['corolla', 'mazda', 'nissan', 'audi', 'dodge', 'bmw', 'hyundai', 'kia', 'ford', 'holden']

wordfind_generator = WordfindGenerator.new(cars, 10, 10, false)
results = wordfind_generator.generate

puts "Wordfind:"
wordfind_generator.show(results[:final_wordfind])

puts "\nSolution:"
wordfind_generator.show(results[:wordfind_solution])

puts "\nWords in Wordfind:"
puts results[:words_in_wordfind]

puts "\nWords not in Wordfind:"
puts results[:words_not_in_wordfind]
