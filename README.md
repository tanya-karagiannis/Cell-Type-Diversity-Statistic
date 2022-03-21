# Cell Type Diversity Statistic
Cell Type Diversity Statistic: An entropy-based metric to compare overall cell type composition across samples

Citation:
Karagiannis, T.T, Monti, S, Sebastiani, P (2022). Cell Type Diversity Statistic: An entropy-based metric to compare cell type composition across samples. Front Genet.(Provisionally Accepted).

## Dependencies
* Before running the CTDS.score function, make sure that R is installed.
* Install the following R packages if not installed already:

```
install.packages("tidyverse")
install.packages("Seurat")
install.packages("SingleCellExperiment")
install.packages("hablar")
install.packages("broom")
install.packages("patchwork")
```
## Usage
First run the source code from CTDS_function.R to load the CTDS.score function into R.

```
source("~/CTDS/R/CTDS_function.R")
```

To run CTDS.score on a matrix or table of cell type proportions (samples in rows v. cell types in columns), input the dataobject to return a vector of the cell type diversity statistics across samples. 

```
CTDS.score(dataobject)
```

Optionally include a matrix of metadata information for each sample (metaInfo) to return a matrix with the cell type diversity statistics across samples and their metadata information.

```
CTDS.score(dataobject, metadata = metaInfo)
```

CTDS.score can alternatively take a SingleCellExperiment object or Seurat object and calculate the cell type proportions for each sample based on the sample variable (sample.ID) and cell type variable (cell.type) specified. Then the function will calculate the cell type diversity statistics across samples.

To return a vector of the cell type diversity statistics across samples:
```
CTDS.score(dataobject, sample = "sample.ID", cell.type = "cell.type")
```

Including metadata information to return a matrix with the cell type diversity statistics across samples joined with their metadata information.
```
CTDS.score(dataobject, sample = "sample.ID", cell.type = "cell.type", metadata = metaInfo)
```



