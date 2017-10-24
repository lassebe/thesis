target_dir=$1
script_dir=${PWD}


if test $# -ne 1
then
    echo "Usage: Give a name of a target directory in the experiments folder."
    exit 1
fi

if [[ ! -d "../experiments/${target_dir}" ]]; then
    echo "Directory ../experiments/${target_dir} does not exist"
    exit 1
fi

echo "${target_dir}" >> output

cd "../experiments/${target_dir}/scripts"


./install.sh orig && ./runJPF.sh orig default | 
  grep "native-method-list:*" |
  ruby "${script_dir}/count_native_methods.rb" |
  sort | uniq -c | sort >> "${script_dir}/output"

