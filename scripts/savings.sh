
#airline piper  takes a "long" time
orig=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4 pool5 pool6 producerconsumer sleepingBarber twoStage  )
fixed=( groovy lang log4j1 log4j2 log4j3 pool1 pool2 pool3 pool6  )

experiment_path="../experiments"
result="savings"
rm ${result}
touch ${result}


for dir in "${orig[@]}"; do
  #statements
  echo "running " ${dir}
  ${experiment_path}/${dir}/scripts/install.sh orig &> /dev/null
  echo ${dir} >> ${result} 
  time ${experiment_path}/${dir}/scripts/runJPF.sh orig default |
    grep "Saved " >> ${result}
done


  echo "" >> ${result}
  echo "fixed" >> ${result}
for dir in "${fixed[@]}"; do
  #statements
  echo "running " ${dir}
  ${experiment_path}/${dir}/scripts/install.sh fixed &> /dev/null
  echo ${dir} >> ${result} 
  time ${experiment_path}/${dir}/scripts/runJPF.sh fixed default |
    grep "Saved " >> ${result}
done