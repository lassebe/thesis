
targets = ['vanilla/orig/', 'summaries/orig/','summaries/fixed/', 'vanilla/fixed/', 
             'vanilla/stateless-orig/', 'summaries/stateless-orig/' ]
targets.each do |target|
  path="/home/lasse/thesis/scripts/times/#{target}"
  puts target
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
    mean = times.inject(0){|sum, t| sum + t } / times.size.to_f

    variance = times.inject(0){|accum, i| accum + (i - mean) ** 2 } / (times.size-1).to_f
    stdev = Math.sqrt(variance)
    two_std_error = stdev / Math.sqrt(times.size)

    mapping[filename] = "#{mean}\t#{two_std_error}"
  end

  mapping.keys.sort.each do |experiment|
    puts "#{experiment}\t#{mapping[experiment]}"
  end
end