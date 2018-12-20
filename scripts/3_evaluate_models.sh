#!/bin/bash

#ocropus-econf -e evaluation/mixed_score.txt test/*/*gt.txt

for model in `ls models/mixed/*00020000*`
do
 model_score=`echo ${model##*/}`
 /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred --probabilities -q -Q 4 -m $model 'test/*/*.bin.png'
 /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-econf -e evaluation/mixed/${model_score}_score.txt test/*/*gt.txt
done

for model in `ls models/sjd/*00020000*`
do
 model_score=`echo ${model##*/}`
 /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred --probabilities -q -Q 4 -m $model 'test/*/*.bin.png'
 /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-econf -e evaluation/sjd/${model_score}_score.txt test/*/*gt.txt
done
