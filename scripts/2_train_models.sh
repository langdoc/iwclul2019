#!/bin/bash

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 100 -c ./train/mixed/*gt.txt --ntrain 100000 -o models/mixed/mixed ./train/mixed/*bin.png
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 100 -c ./train/sjd/*gt.txt --ntrain 100000 -o models/sjd/sjd ./train/sjd/*bin.png

