
#airline piper  takes a "long" time
array=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4 pool5 pool6 producerconsumer sleepingBarber twoStage  )
experiment_path="../experiments"
result_dir="stats"

for experiment in "${array[@]}"; do
  result=${result_dir}/${experiment}  
  echo "running " ${experiment}
  ${experiment_path}/${experiment}/scripts/install.sh orig &> /dev/null
  #echo ${experiment} > ${result}/${experiment} 
  time ${experiment_path}/${experiment}/scripts/runJPF.sh orig default |
    grep "methodStats" > ${result} #|
    #ruby parse-methodstats.rb >> ${result}


done