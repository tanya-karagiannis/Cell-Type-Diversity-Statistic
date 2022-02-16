#' Calculate Cell Type Diversity Statistic
#'
#' This function calculates the cell type diversity statistic for each sample 
#' from a matrix with samples specified in rows and cell types specified in 
#' the columns. The matrix can be given as an input or generated from a Seurat object 
#' or SingleCellExperiment object. If the column sums of the matrix do not equal to 1, 
#' the function will return a warning message to fix the matrix.
#' 
#'
#' @param normprop A matrix of the normalized cell type proportions with samples by row and 
#' cell types by column, or SingleCellExperiment Object or Seurat Object to pull data from.
#' @param sample Variable name for sample ID if extracting from SingleCellExperiment or Seurat Object.
#' @param cell.type Variable name for cell type if extracting variable from SingleCellExperiment or Seurat Object.
#' @param metadata A matrix of the sample level metadata information including sample by row 
#' and sample ID variable and other metadata variables by column.
#' @return A matrix of the cell type diversity statistics for each sample joined with metadata 
#' information if provided
#' @export
#' 

CTDS.score <- function(dataobj,
                       sample = "sample.ID",
                       cell.type = "ct.consensus",
                       metadata = NULL){
  require(tidyverse)
  if(class(dataobj) == "matrix" | class(dataobj) == "table"){
    normprop.table <- dataobj
    #return(normprop.table)
  }else if(class(dataobj) == "SingleCellExperiment"){
    normprop.table <- prop.table(table(dataobj@colData[,sample], dataobj@colData[,cell.type]), margin = 1)
    #return(normprop.table)
  }else if(class(dataobj) == "Seurat"){
    normprop.table <- prop.table(table(dataobj@meta.data[,sample], dataobj@meta.data[,cell.type]), margin = 1)
    #return(normprop.table)
  }else{
    warning("The data object is not a matrix, Seurat object, or a SingleCellExperiment object")
  }
  
  #check if column sums equal to 1
  normprop.sum <- apply(normprop.table, 1, sum)
  #return(normprop.sum)
  if(normprop.sum == 1){
    normprop.table <- normprop.table
  }else{
    warning("The normalized proportions for each sample do not add up to 1")
  }
  
  div.res <- apply(normprop.table, 1, function(x){(-sum(x*log(x), na.rm = T)/log(ncol(normprop.table))-1)})
  if(is.null(metadata) == TRUE){
    div.mat <- tibble::enframe(div.res, name = sample, value = "statistic")
    return(div.mat)
  } else{
    div.meta <- tibble::enframe(div.res, name = sample, value = "statistic") %>%
                dplyr::full_join(metadata, by = sample)
    return(div.meta)
  }
  
  
}
