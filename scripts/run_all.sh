
#airline piper  takes a "long" time
array=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4 pool5 pool6 producerconsumer sleepingBarber twoStage  )
experiment_path="../experiments"
result="stats"
rm ${result}
touch ${result}


for dir in "${array[@]}"; do
  #statements
  echo "running " ${dir}
  ${experiment_path}/${dir}/scripts/install.sh orig &> /dev/null
  echo ${dir} >> ${result} 
  ${experiment_path}/${dir}/scripts/runJPF.sh orig default >> ${result}
done