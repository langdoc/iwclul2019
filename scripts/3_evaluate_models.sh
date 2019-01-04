#!/bin/bash

for model in `ls models/mixed/*00050000*`
do
 model_score=`echo ${model##*/}`
 ocropus-rpred --probabilities -q -Q 4 -m $model 'test/*/*.bin.png'
 ocropus-econf -e evaluation/mixed/${model_score}_score.txt test/*/*gt.txt
done

for model in `ls models/sjd/*00050000*`
do
 model_score=`echo ${model##*/}`
 ocropus-rpred --probabilities -q -Q 4 -m $model 'test/*/*.bin.png'
 ocropus-econf -e evaluation/sjd/${model_score}_score.txt test/*/*gt.txt
done
