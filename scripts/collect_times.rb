class Result
  attr_accessor :experiment, :vanilla_mean, :vanilla_error, :summ_mean, :summ_error
  def initialize(experiment)
    @experiment = experiment
  end
end

results = []
targets = ['orig', 'fixed'] # ['stateless-orig']
targets.each do |target|
  path="/home/lasse/thesis/scripts/times/#{target}/vanilla/"
  Dir.foreach(path) do |filename|
    next if filename == '.' or filename == '..'
    # do work on real filenames

    res = Result.new(filename+"-#{target}")
    
    ['vanilla/', 'summaries/'].each do |type| 
      data = File.read("/home/lasse/thesis/scripts/times/#{target}/"+type+filename).split("\n")
      times = []
      data.each do |datum|
        times << datum.split(":")[1].chop.to_i
      end
      # #{times.inject{ |sum, el| sum + el }.to_f / times.size}
      mean = times.inject(0){|sum, t| sum + t } / times.size.to_f

      variance = times.inject(0){|accum, i| accum + (i - mean) ** 2 } / (times.size-1).to_f
      stdev = Math.sqrt(variance)
      interval = 1.833113 * stdev / Math.sqrt(times.size)
      if type == 'vanilla/' 
        res.vanilla_mean = mean
        res.vanilla_error = interval
      else
        res.summ_mean = mean
        res.summ_error = interval
      end
    end


    results << res

  end



end
  
  puts '\begin{tabular}[h]{lrrr}'
  puts '\hline'
  puts 'Experiment & original JPF (ms) & with summaries (ms) & Relative change \\\\'
  results.sort { |a, b| a.vanilla_mean <=> b.vanilla_mean }.each do |res|
    if res.vanilla_mean < res.summ_mean
      next if res.vanilla_mean + res.vanilla_error >= res.summ_mean - res.summ_error
    else
      next if res.summ_mean + res.summ_error >= res.vanilla_mean - res.vanilla_error
    end
    puts ' \hline'
    print "#{res.experiment} & #{res.vanilla_mean} & #{res.summ_mean} & #{(res.summ_mean.to_f / res.vanilla_mean).round(2)} \\\\" # \t#{res.error}
  end
  puts ' \hline'

  puts '\end{tabular}'


#  organised = results.group_by {|res| res.vanilla_mean.to_s.size }       
#  i=0
#  organised.keys.sort.each do |mag| 
#    puts "id type exper mean se"
#    organised[mag].sort_by { |e| e.vanilla_mean }.each_with_index do |exp|
#      puts "#{i} vanilla #{exp.experiment} #{exp.vanilla_mean} #{exp.vanilla_error}"
#      i+=1
#      puts "#{i} summaries #{exp.experiment} #{exp.summ_mean} #{exp.summ_error}"
#      i+=1
#    end
#    puts
#  end