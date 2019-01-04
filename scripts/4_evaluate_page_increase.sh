#!/bin/bash

mkdir evaluation
mkdir evaluation/incr

# the test is done here for each model trained for 10,000 steps

for model in `ls models/incr/*10000.pyrnn.gz`
do
  model_score=`echo ${model##*/}`
  ocropus-rpred -q -Q 4 -m $model 'test/sjd/*.bin.png'
  ocropus-econf -e evaluation/incr/${model_score}_score.txt test/sjd/*gt.txt
done
