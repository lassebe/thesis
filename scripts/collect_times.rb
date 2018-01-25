
path='/home/lasse/thesis/scripts/times/'

mapping = {}
Dir.foreach(path) do |filename|
  next if filename == '.' or filename == '..'

  # do work on real filenames
  data = File.read(path+filename).split("\n")
  times = []
  data.each do |datum|
    times << datum.split(":")[1].chop.to_i
  end
  # #{times.inject{ |sum, el| sum + el }.to_f / times.size}
  mapping[filename] = "#{times.join("\t")}"
end

mapping.keys.sort.each do |experiment|
  puts "#{experiment}\t#{mapping[experiment]}"
end