require "rubygems"
require "json"


#JSON.parse(input_file)
stats = JSON.parse(STDIN.gets)

#interrupting_methods = Hash.new(0)
puts "name\trecorded\ttotal calls\tcontext match\tratio (match/total)\tinterruption"



stats["methodStats"].sort_by { |s| [s["recorded"] ? 1 : 0, s["argsMatchCount"], s["totalCalls"]] }.reverse.each do |methodStats|
  print "#{methodStats["methodName"]}\t#{methodStats["recorded"]}\t#{methodStats["totalCalls"]}\t"
  if methodStats["recorded"]
    print "#{methodStats["argsMatchCount"]}\t#{methodStats["argsMatchCount"].to_f / methodStats["totalCalls"]}\t\"\"" 
  else
    print "0\t0\t#{methodStats["interruption"]}"
  end
  puts
end

puts
