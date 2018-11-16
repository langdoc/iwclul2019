#!/bin/bash

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 100 -c ./train/sjd/*gt.txt --ntrain 100000 -o models/sjd/sjd-test-1 ./train/sjd/*bin.png

