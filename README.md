This is a paper that tests building OCR systems for Unified Northern Alphabet, using Ground Truth data package [Unified-Northern-Alphabet-OCR](https://github.com/langdoc/unified-northern-alphabet-ocr) built by Partanen and Rießler in 2018.

The tests reported in the study are as follows:

- mixed OCR model containing data from Kildin Saami, Northern Mansi, Selkup and Tundra Nenets
- monolingual Kildin Saami model
- additional tests on unseen Evenki data
- additional retraining of the model to capture Evenki particularities

The paper concludes that with very few resources it is possible to build state-of-the-art performing OCR model for writing systems such as Unified Northern Alphabet. The Evenki tests demonstrate a workflow that would allow analysing any of the languages written in this alphabet.

All materials used are stored in the National Library of Finland's Fenno-Ugrica collection, except the Evenki data, which is available [in the University of Latvia's library](https://dspace.lu.lv/dspace/handle/7/28251). 

## Reproducibility

The results in the study can be repeated by following commands. Ocropy has to be installed in the local environment.

```
# This will clone the training data
bash scripts/0_prepare_data.sh 

# This splits the data into training and testing sets
# it also reports basic information about the data
Rscript scripts/1_process_data.R

# This trains the models adding one page each round
bash scripts/2_train_incremental_models.sh

# This evaluates the improvement
bash scripts/4_evaluate_page_increase.sh

# SORRY! You need to copy manually the output of that 
# script and save it to this file :( For example:
pbpaste > evaluation/incr/incr_log

# This saves the figure about the increase
# into file plots/figure_5.png
Rscript scripts/4_plot_page_increase.R


```