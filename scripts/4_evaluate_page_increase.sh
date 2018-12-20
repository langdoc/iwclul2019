#!/bin/bash

mkdir evaluation

for model in `ls models/incr/*10000.pyrnn.gz`
do
  model_score=`echo ${model##*/}`
  /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -q -Q 4 -m $model 'test/sjd/*.bin.png'
  ocropus-econf -e evaluation/incr/${model_score}_score.txt test/sjd/*gt.txt
done