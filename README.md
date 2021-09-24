# Cell Type Distribution Score
Cell Type Distribution Score: A novel approach to measure the overall cell type composition of samples at a single cell level

## Dependencies
* Before running the CTDS.score function, make sure that R is installed.
* Install the following R packages if not installed already:
in R:
```
install.packages("dplyr")
install.packages("Seurat")
install.packages("SingleCellExperiment")
install.packages("ggplot2")
install.pacakges("reshape2"))
```
## Usage
First run the source code from distribution_score.R to load the CTDS.score function into R.

```
source("~/CTDS/R/distribution_score.R")
```

To run CTDS.score on a matrix or table of normalized cell type proportions (samples in rows v. cell types in columns), input the dataobject to return a vector of the cell type distribution scores across samples. 

```
CTDS.score(dataobject)
```

Optionally include a matrix of metadata information for each sample (metaInfo) to return a matrix with the cell type distribution scores across samples and their metadata information.

```
CTDS.score(dataobject, metadata = metaInfo)
```

CTDS.score can alternatively take a SingleCellExperiment object or Seurat object and calculate the normalized cell type proportions for each sample based on the sample variable (sample.ID) and cell type variable (ct.consensus) specified. Then the function will calculate the cell type distribution scores across samples.

To return a vector of the cell type distribution scores across samples:
```
CTDS.score(dataobject, sample = "sample.ID", cell.type = "ct.consensus")
```

Including metadata information to return a matrix with the cell type distribution scores across samples and their metadata information.
```
CTDS.score(dataobject, sample = "sample.ID", cell.type = "ct.consensus", metadata = metaInfo)
```



