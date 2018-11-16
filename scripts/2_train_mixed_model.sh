#!/bin/bash

rm ./train/mixed/*

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain -F 100 -c ./train/mixed/*gt.txt --ntrain 100000 -o models/mixed/una- ./train/mixed/*bin.png

