input = STDIN.readlines

map = Hash.new(0)

input.each do |line|
  n = line.split(" ")[0].to_i
  method_name = line.split(" ")[1]
  map[method_name] += n
end

map.sort_by {|key,val| val}.each do |k,v|
  puts "#{v} #{k}"
end