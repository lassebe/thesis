#!/bin/bash
#airline piper  takes a "long" time
#array=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4  pool6 producerconsumer sleepingBarber twoStage  )
target=$1
arrary=()

result_dir=""


if [[ $target == 'orig' ]]; then
  # array=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4 pool5 pool6 producerconsumer sleepingBarber twoStage  )
  array=( log4j3 )
  result_dir="orig"
elif [[ $target == 'fixed' ]]; then
  array=( groovy lang log4j1 log4j2 log4j3 pool1 pool2 pool3 pool6  )
  result_dir="fixed"
elif [[ $target == 'stateless-orig' ]]; then
  array=(  alarmclock boundedBuffer  deadlock groovy lang loseNotify pool3  sleepingBarber twoStage  )
  result_dir="stateless-orig"
else
  echo 'incorrect target, must be one of [orig, fixed, stateless-orig]'
  exit 1
fi

experiment_path="../experiments"
result_dir="times/summaries/"$target

for experiment in "${array[@]}"; do
  result=${result_dir}/${experiment}
  echo "running " ${experiment}
  ${experiment_path}/${experiment}/scripts/install.sh orig &> /dev/null
  # echo ${experiment} > ${result}/${experiment} 

  time ${experiment_path}/${experiment}/scripts/runJPF.sh orig default \
    | grep "{Time:"  \
     > ${result}
  for (( i=1; i<=9; i++)) 
  do
    time ${experiment_path}/${experiment}/scripts/runJPF.sh orig default \
      | grep "{Time:" \
      >> ${result}
  done


done