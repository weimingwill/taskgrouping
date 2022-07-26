mkdir -p log
now=$(date +"%Y%m%d_%H%M%S")

root_dir=/mnt/lustre/$(whoami)
project_dir=$root_dir/projects/taskgrouping
data_dir=$root_dir/datasets/taskonomy_datasets

export PYTHONPATH=$PYTHONPATH:${pwd}

job_name=taskgrouping

srun -u --partition=innova --job-name=${job_name} \
    -n1 --gres=gpu:1 --ntasks-per-node=1 \
    python ${project_dir}/train_taskonomy.py -d=${data_dir} -a=xception_taskonomy_small \
      -j 4 -b 64 -lr=.1 --fp16 -sbn --tasks=sdnke -r 2>&1 | tee log/${job_name}-${now}.log &
