rm -f ./logs/*
echo 'mixed x mixed'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/*/*.bin.png' &> logs/mixedxmixed
echo 'mixed x mns'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/mns/*.bin.png' &> logs/mixedxmns
echo 'mixed x sel'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/sel/*.bin.png' &> logs/mixedxsel
echo 'mixed x sjd'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/sjd/*.bin.png' &> logs/mixedxsjd
echo 'mixed x yrk'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/yrk/*.bin.png' &> logs/mixedxyrk
echo 'sjd x mixed'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/*/*.bin.png' &> logs/sjdxmixed
echo 'sjd x mns'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/mns/*.bin.png' &> logs/sjdxmns
echo 'sjd x sel'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/sel/*.bin.png' &> logs/sjdxsel
echo 'sjd x sjd'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/sjd/*.bin.png' &> logs/sjdxsjd
echo 'sjd x yrk'
/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/yrk/*.bin.png' &> logs/sjdxyrk

echo 'starting probability-tests'

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q --probabilities -Q 4 -m ./models/mixed/mixed-00030000.pyrnn.gz 'test/*/*.bin.png'
mv test/*/*prob logs/probs_sjd/

/Users/niko/anaconda3/envs/ocropus_env/bin/ocropus-rpred -r -q --probabilities -Q 4 -m ./models/sjd/sjd-00030000.pyrnn.gz 'test/*/*.bin.png'
mv test/*/*prob logs/probs_sjd/
