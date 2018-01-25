target=$1

array=()
result_dir=""

echo $1
echo target
if [[ $target == 'orig' ]]; then
  array=( account alarmclock boundedBuffer clean deadlock diningPhilosophers groovy lang linkedlist log4j1 log4j2 log4j3 loseNotify pool1 pool2 pool3 pool4 pool5 pool6 producerconsumer sleepingBarber twoStage  )
  result_dir="stats-orig"
elif [[ $target == 'fixed' ]]; then
  array=( groovy lang log4j1 log4j2 log4j3 pool1 pool2 pool3 pool6  )
  result_dir="stats-fixed"
elif [[ $target == 'stateless-orig' ]]; then
  array=(  alarmclock boundedBuffer clean deadlock groovy lang loseNotify pool3 pool4 pool6  sleepingBarber twoStage  )
  result_dir="stats-stateless-orig"
elif [[ $target == 'stateless-fixed' ]]; then
  array=()
  result_dir="stats-stateless-orig"
else
  echo 'incorrect target'
  exit 1
fi


experiment_path="../experiments"

for experiment in "${array[@]}"; do
  result=stats/${result_dir}/${experiment}
  echo $result
  echo "running " ${experiment}
  ${experiment_path}/${experiment}/scripts/install.sh orig &> /dev/null
  time ${experiment_path}/${experiment}/scripts/runJPF.sh orig default |
    grep "methodStats" > ${result} 
done