#!/bin/bash

for model in `ls models/sjd/*`
do
  #png=$(echo $pdf | sed 's/pdf/png/g')
  model_score=`echo ${model##*/}`
  /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred --probabilities -q -Q 4 -m $model 'test/*.bin.png'
  ocropus-econf -e evaluation/sjd/${model_score}_score.txt test/*gt.txt
done
