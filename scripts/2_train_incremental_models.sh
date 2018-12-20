for filelist in `ls training_lists/*.txt`
do
 number=$(echo $filelist | sed 's/training_lists\/sjd-train-//g' | sed 's/.txt//g')
 /Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rtrain --file $filelist -F 2000 -c ./train/sjd/*gt.txt --ntrain 10000 -o models/incr/sjd-$number
done