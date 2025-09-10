require_relative 'hashmap'

test = HashMap.new

# Fill up to load factor
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "Length after initial inserts: #{test.length}"  # should be 12
puts "Capacity: #{test.capacity}"                    # should still be 16

# Overwrite values
test.set('apple', 'green')
test.set('dog', 'black')
test.set('jacket', 'gray')

puts "Length after overwrites: #{test.length}"      # should still be 12
puts "Capacity after overwrites: #{test.capacity}"  # should still be 16

# Trigger resize
test.set('moon', 'silver')
puts "Length after adding moon: #{test.length}"     # should be 13
puts "Capacity after resize: #{test.capacity}"      # should be 32

# Check other methods
puts "Get apple: #{test.get('apple')}"              # should be "green"
puts "Has banana? #{test.has?('banana')}"           # true
puts "Has pizza? #{test.has?('pizza')}"             # false

test.remove('lion')
puts "Length after removing lion: #{test.length}"   # should be 12

puts "Keys: #{test.keys.inspect}"
puts "Values: #{test.values.inspect}"
puts "Entries: #{test.entries.inspect}"

test.clear
puts "Length after clear: #{test.length}"           # should be 0
