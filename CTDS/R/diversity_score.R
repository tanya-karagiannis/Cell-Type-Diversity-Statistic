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
#' @param metadata A matrix of the metadata information with samples by row and metadata variables by column
#' @return A vector of cell type distribution scores for each sample with metadata information if given
#' @export
#' 

CTDS.score <- function(dataobj,
                       sample = "sample.ID",
                       cell.type = "ct.consensus",
                       metadata = NULL){
  
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
      warning("The data object is not a matrix or a SingleCellExperiment object")
    }
    
  
   normprop.sum <- apply(normprop.table, 1, sum)
   #return(normprop.sum)
   if(all(normprop.sum) == 1){
     normprop.table <- normprop.table
   }else{
     warning("The normalized proportions for each sample do not add up to 1")
   }

  div.res <- apply(normprop.table, 1, function(x){-sum(x*log(x), na.rm = T)})
  if(is.null(metadata) == TRUE){
     return(div.res)
   } else{
     div.meta <- cbind.data.frame(score = matrix(div.res), metadata)
     return(div.meta)
   }
   

}
  

