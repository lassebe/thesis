input = STDIN.readline
native_methods = input.split(":")[1]
puts "==Native methods=="
native_methods.split(",").each do |m|
  puts m
end