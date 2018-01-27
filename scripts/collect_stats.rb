require "rubygems"
require "json"

target = STDIN.gets
# orig fixed stateless-orig 
path="/home/lasse/thesis/scripts/stats/#{target}/"

class MethodStats
  attr_reader :method_name, :totalCalls, :recorded, :argsMatchCount, :interruption
  def initialize(method_name, totalCalls, recorded, argsMatchCount, interruption)
    @method_name = method_name
    @totalCalls = totalCalls
    @recorded = recorded
    @argsMatchCount = argsMatchCount
    @interruption = interruption
  end

  def to_str
    "#{@method_name}\t#{@totalCalls}\t#{@recorded}\t#{@argsMatchCount}\t#{@interruption}"
  end

end


class ExperimentStats
  attr_reader :experiment_name, :num_methods, :recorded_methods
  attr_accessor :method_stats
  def initialize(experiment_name, num_methods, recorded_methods)
    @experiment_name = experiment_name
    @num_methods = num_methods
    @recorded_methods = recorded_methods
    @method_stats = []
  end
end

# sums the "parameter" for each recorded method
# for example, to count the number of calls to recorded methods
# use count_recorded(stats, "totalCalls")
def count_recorded(methodStats, parameter)
  methodStats.inject(0) {|sum, ms| recorded(ms) ? sum + ms[parameter] : sum }
end

def recorded(methodStats)
  methodStats["recorded"]
end

results = []
experiments = []
Dir.foreach(path) do |filename|
  next if filename == '.' or filename == '..'
  # do work on real filenames

  methodStats = JSON.parse(File.read(path+filename))["methodStats"]
  recorded_methods = methodStats.count {|ms| ms["recorded"]}
  exp = ExperimentStats.new(filename, methodStats.size, recorded_methods)

  methodStats.each do |ms|
    exp.method_stats << MethodStats.new(ms["methodName"], ms["totalCalls"], ms["recorded"],
                                           ms["argsMatchCount"], ms["interruption"])
  end
  
  calls_to_summarised = count_recorded(methodStats, "totalCalls")
  successful_matches = count_recorded(methodStats, "argsMatchCount")
  results << "#{filename} #{recorded_methods} #{methodStats.size} #{successful_matches} #{calls_to_summarised}" 
  experiments << exp
end

puts "experiment_name recorded_methods total_methods matches calls_to_summarised"
results.sort.each do |res|
  puts res
end

reasons = ['<clinit>','<init>','array type','blacklisted','native method','shared field read','static read', 'transition or lock']

print " \t"
print reasons.join("\t")
puts
experiments.sort_by {|exp| exp.experiment_name }.each do |exp|
  print "#{exp.experiment_name}"
  interruptions = exp.method_stats.find_all { |ms| not ms.recorded }.group_by { |ms| ms.interruption }
  reasons.each do |reason|
    if interruptions[reason].nil?
      print "\t0"
    else
      print "\t#{interruptions[reason].size}"
    end
  end
  puts
end

