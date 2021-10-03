library(Seurat)
library(patchwork)
library(ggrepel)
library(sparseMatrixStats)
library(tidyverse)
library(plotly)
library(gplots)
library(plotly)
library(AneuFinder)

infercnv_karyotypeMeasures <- function(expr.data, group_list, physio_state = 1, breaks = NULL){
  # Parameters: 
  # expr.data - final inferCNV object expr.data slot converted to a dataframe
  # group_list - named list containing IDs for each group
  # physio_state - vector of normal expression states for each cell, default = 1
  # breaks - vector with intervals to discretize. Leaving as NULL uses the default
  
  # Set up empty data frame for group scores
  karyotype_scores_df <- setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("group", "aneuploidy_score", "heterogeneity_score"))
  
  # Set up intervals for data discretization
  if(is.null(breaks)){
    mean_infercnv = mean(rowMeans(expr.data))
    break_intervals = c(-Inf, mean_infercnv * seq(0, 10, 0.1), Inf) + mean_infercnv*0.05
  } else {
    break_intervals <- breaks
  }
  
  for(i in 1:length(group_list)){
    print(paste0("Processing group: ", names(group_list)[i], ", ", i, "/", length(group_list)))
    
    # Calculate the aneuploidy score for each gene, mean over cells from a group minus
    # the physiological state (infer_cnv reference)
    aneuploidy_gene_scores = rowMeans(abs(expr.data[, group_list[[i]]] - physio_state))
    aneuploidy_score = mean(aneuploidy_gene_scores)
    
    # Discretize expression matrix, using intervals relative to the mean expression state,
    #or the intervals provided as a parameter
    CNVexp_discrete <- apply(expr.data, MARGIN = 2, FUN = function(x){
      cut(x, breaks = break_intervals)
    })
    
    # Tabulate the distribution of discrete cell states for each gene. Sort from most to least
    # common. This counts how many cells are in each discrete bin, for each gene.
    heterogeneity_gene_tabs <- apply(CNVexp_discrete[, group_list[[i]]], 1, FUN = function(x) {
      sort(table(x), decreasing = TRUE)})
    
    # Calculate the heterogeneity score for each gene, by multiplying the vector with frequencies of cells 
    #with a weighting vector c(0,1,2,..., length(frequencies)-1), summing over the result and dividing by 
    # the number of cells
    heterogeneity_gene_scores <- unlist(lapply(heterogeneity_gene_tabs, function(x) {
      sum(x * 0:(length(x) - 1))
    }))/sum(group_list[[i]])
    
    # The heterogeneity score is calculated as the mean of all genes for each group. 
    heterogeneity_score = mean(heterogeneity_gene_scores)
    
    # Transform group scores into a data frame and append
    group_karyotype_scores = data.frame(names(group_list)[i], aneuploidy_score, heterogeneity_score)
    colnames(group_karyotype_scores) <- c("group", "aneuploidy_score", "heterogeneity_score")
    karyotype_scores_df <- karyotype_scores_df %>% rbind(group_karyotype_scores)
  }
  
  return(karyotype_scores_df)
}