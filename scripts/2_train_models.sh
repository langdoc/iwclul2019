#!/bin/bash

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 2500 -c ./train/mixed/*gt.txt --ntrain 100000 -o models/mixed/mixed ./train/mixed/*bin.png
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 2500 -c ./train/sjd/*gt.txt --ntrain 100000 -o models/sjd/sjd ./train/sjd/*bin.png

#for filelist in `ls training_lists/*.txt`
#do
#  number=$(echo $filelist | sed 's/training_lists\/sjd-train-//g' | sed 's/.txt//g')
#  /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain --file $filelist -F 2000 -c ./train/sjd/*gt.txt --ntrain 20000 -o models/incr/sjd-$number
#done

#
# # saving models/incr/sjd-{training_lists/01}-00000010.pyrnn.gz
# sh: models/incr/sjd-{training_lists/01}-00000010.pyrnn.gz: No such file or directory