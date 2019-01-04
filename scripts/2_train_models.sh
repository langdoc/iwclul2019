#!/bin/bash

ocropus-rtrain -F 2500 -c ./train/mixed/*gt.txt --ntrain 50000 -o models/mixed/mixed ./train/mixed/*bin.png
ocropus-rtrain -F 2500 -c ./train/sjd/*gt.txt --ntrain 50000 -o models/sjd/sjd ./train/sjd/*bin.png
