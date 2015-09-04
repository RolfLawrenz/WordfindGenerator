require_relative "../wordfind_generator"

describe WordfindGenerator do

  it 'should create a wordfind' do
    cars = ['corolla', 'mazda', 'nissan']
    generator = WordfindGenerator.new(cars, 7,7)
    results = generator.generate
    generator.show(results[:wordfind_solution])
    puts ""
    generator.show(results[:final_wordfind])
    expect(results[:wordfind_solution].size).to eq(49)
    expect(results[:words_in_wordfind]).to eq(cars)
    expect(results[:words_not_in_wordfind]).to eq([])
  end

  it 'should create a wordfind in uppercase' do
    cars = ['corolla', 'mazda', 'nissan']
    generator = WordfindGenerator.new(cars, 7,7, false)
    results = generator.generate
    generator.show(results[:wordfind_solution])
    puts ""
    generator.show(results[:final_wordfind])
    expect(results[:wordfind_solution].size).to eq(49)
    expect(results[:words_in_wordfind]).to eq(cars.map(&:upcase))
    expect(results[:words_not_in_wordfind]).to eq([])
  end

  it 'should create a wordfind but miss words too long' do
    cars = ['corolla', 'mazda', 'nissan', 'mercedes']
    generator = WordfindGenerator.new(cars, 7,7)
    results = generator.generate
    generator.show(results[:wordfind_solution])
    puts ""
    generator.show(results[:final_wordfind])
    expect(results[:wordfind_solution].size).to eq(49)
    expect(results[:words_in_wordfind]).to eq(cars - ['mercedes'])
    expect(results[:words_not_in_wordfind]).to eq(['mercedes'])
  end

  it 'should create a wordfind with lots of words' do
    cars = ['corolla', 'mazda', 'nissan', 'audi', 'dodge', 'bmw', 'hyundai', 'kia', 'ford', 'holden']
    generator = WordfindGenerator.new(cars, 7,7)
    results = generator.generate
    generator.show(results[:wordfind_solution])
    puts ""
    generator.show(results[:final_wordfind])
    puts "\nwords_not_in_wordfind=#{results[:words_not_in_wordfind]}"
    expect(results[:wordfind_solution].size).to eq(49)
  end


end