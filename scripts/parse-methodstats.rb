require "rubygems"
require "json"


#JSON.parse(input_file)
stats = JSON.parse(STDIN.gets)

#interrupting_methods = Hash.new(0)
puts "name\trecorded\ttotal calls\tcontext match\tratio (match/total)\tinterruption"

stats["methodStats"].sort_by { |s| [s["counter"]["recorded"] ? 1 : 0, s["counter"]["argsMatchCount"], s["counter"]["totalCalls"]] }.reverse.each do |methodStats|
  counter = methodStats["counter"]
  #next if counter["argsMatchCount"] == 0
  #if counter["interruptedByNativeCall"] 
    #interrupting_methods[counter["interruptingMethod"]] += 1
  #end
  print "#{methodStats["methodName"]}\t#{counter["recorded"]}\t#{counter["totalCalls"]}\t"
  if counter["recorded"]
    print "#{counter["argsMatchCount"]}\t#{counter["argsMatchCount"].to_f / counter["totalCalls"]}\t\"\"" 
  else
    print "0\t0\t#{counter["interruptingMethod"]}"
  end
  puts
end

puts

# this could just as well be done in Sheets
#interrupting_methods.sort_by { |_key, value| value  }.reverse.each do |methodname, count|
  #puts "#{count}\t#{methodname}"
#end