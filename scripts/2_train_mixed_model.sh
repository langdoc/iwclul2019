#!/bin/bash

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 100 -c ./train/multi/*gt.txt --ntrain 100000 -o models/mixed/una-test-1 ./train/*bin.png

