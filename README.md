# An OCR system for the Unified Northern Alphabet

This is data repository for the article "An OCR system for the Unified Northern Alphabet" forthcoming in IWCLUL conference proceedings. The authors are Niko Partanen and Michael Rießler.

The paper concludes that with very few resources it is possible to build state-of-the-art performing OCR model for writing systems such as Unified Northern Alphabet. 

All materials used are stored in the National Library of Finland's Fenno-Ugrica collection, except the Evenki data, which is available [in the University of Latvia's library](https://dspace.lu.lv/dspace/handle/7/28251). 

## Reproducibility

The results in the study can be repeated by following commands. Ocropy has to be installed in the local environment. **In the current version there are hard-coded paths to Ocropy command line tools, and those have to be changed to run the tests locally.** This will be fixed in final release.

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
# into file plots/figure_4.png
Rscript scripts/4_plot_page_increase.R

# This trains the models for the second test
bash scripts/2_train_models.sh 

# This saves the figure about those results
# into file plots/figure_5.png
Rscript scripts/5_model_plots.R

# This does the Evenki test and prints
# the results into console
Rsript scripts/6_evenki_test.R

```