library(tidyverse)
library(sparseMatrixStats)

GeomSplitViolin <- ggproto("GeomSplitViolin", GeomViolin, 
                           draw_group = function(self, data, ..., draw_quantiles = NULL) {
                             data <- transform(data, xminv = x - violinwidth * (x - xmin), xmaxv = x + violinwidth * (xmax - x))
                             grp <- data[1, "group"]
                             newdata <- plyr::arrange(transform(data, x = if (grp %% 2 == 1) xminv else xmaxv), if (grp %% 2 == 1) y else -y)
                             newdata <- rbind(newdata[1, ], newdata, newdata[nrow(newdata), ], newdata[1, ])
                             newdata[c(1, nrow(newdata) - 1, nrow(newdata)), "x"] <- round(newdata[1, "x"])
                             
                             if (length(draw_quantiles) > 0 & !scales::zero_range(range(data$y))) {
                               stopifnot(all(draw_quantiles >= 0), all(draw_quantiles <=
                                                                         1))
                               quantiles <- ggplot2:::create_quantile_segment_frame(data, draw_quantiles)
                               aesthetics <- data[rep(1, nrow(quantiles)), setdiff(names(data), c("x", "y")), drop = FALSE]
                               aesthetics$alpha <- rep(1, nrow(quantiles))
                               both <- cbind(quantiles, aesthetics)
                               quantile_grob <- GeomPath$draw_panel(both, ...)
                               ggplot2:::ggname("geom_split_violin", grid::grobTree(GeomPolygon$draw_panel(newdata, ...), quantile_grob))
                             }
                             else {
                               ggplot2:::ggname("geom_split_violin", GeomPolygon$draw_panel(newdata, ...))
                             }
                           })

geom_split_violin <- function(mapping = NULL, data = NULL, stat = "ydensity", position = "identity", ..., 
                              draw_quantiles = NULL, trim = TRUE, scale = "area", na.rm = FALSE, 
                              show.legend = NA, inherit.aes = TRUE) {
  layer(data = data, mapping = mapping, stat = stat, geom = GeomSplitViolin, 
        position = position, show.legend = show.legend, inherit.aes = inherit.aes, 
        params = list(trim = trim, scale = scale, draw_quantiles = draw_quantiles, na.rm = na.rm, ...))
}

save_pheatmap_png <- function(x, filename, width=3500, height=7000, res = 300) {
  png(filename, width = width, height = height, res = res)
  grid::grid.newpage()
  grid::grid.draw(x$gtable)
  dev.off()
}

# Plot gene expression of CIN high x low cells
plot_cluster_split_violin <- function(object, id1, id2, gene_list){
  
  # Subset data
  id_1 <- subset(object, idents = id1)
  id_2 <- subset(object, idents = id2)
  
  # Get expression data of relevant genes as a data frame
  mat <- Seurat::GetAssayData(id_1, assay = "RNA", slot = "data")
  mat <- mat[rownames(mat) %in% gene_list, ]
  df1 <- mat %>% t() %>% as.data.frame() %>% mutate(cluster = id1)
  
  mat <- Seurat::GetAssayData(id_2, assay = "RNA", slot = "data")
  mat <- mat[rownames(mat) %in% gene_list, ]
  df2 <- mat %>% t() %>% as.data.frame() %>% mutate(cluster = id2)
  
  # Combine data from both IDs
  df_c <- df1 %>% rbind(df2)
  df_c <- df_c %>% pivot_longer(cols = gene_list, names_to = "gene", values_to = "value")
  
  # Plot
  plot <- df_c %>% mutate(dummy = "dummy") %>% ggplot(aes(x = dummy, y = value, fill = as.factor(cluster))) + geom_split_violin() + facet_wrap(~gene, scales = "free_x") + coord_flip() + labs(x = "", y = "Expression", fill = "Identity", title = deparse(substitute(gene_list))) +  theme(plot.title = element_text(hjust = 0.5))
  print(plot)
  
  #   # Z score and plot
  #   df_z <- df_c %>% group_by(gene) %>% mutate(Z_scored_value =  (value-mean(value))/sd(value), dummy = "dummy")
  # # group_by(cluster, gene)
  #   zplot <- df_z %>% ggplot(aes(x = dummy, y = Z_scored_value, fill = as.factor(cluster))) + geom_split_violin() + facet_wrap(~gene, scales = "free_x") + coord_flip() + labs(x = "", y = "Z-scored expression", title = deparse(substitute(gene_list))) +  theme(plot.title = element_text(hjust = 0.5))
  #   print(zplot)
}

#' Get chunked sets of row-wise or column-wise indices of a matrix 
#' 
#' @name getMatrixBlocks
#'
#' @param mat Input matrix
#' @param chunk.size The size of the chunks to use for coercion
#' @param by.row Whether to chunk in a row-wise fashion
#' @param by.col Whether to chunk in a column-wise fashion
#'
#' @return A set of chunked indices
#' @export
#'
#' @examples
#' #make a sparse binary matrix
#' library(Matrix)
#' m <- 100
#' n <- 1000
#' mat <- round(matrix(runif(m*n), m, n))
#' mat.sparse <- Matrix(mat, sparse = TRUE)
#' 
#' #get row-wise chunks of 10
#' chunks <- getMatrixBlocks(mat.sparse, chunk.size = 10)

getMatrixBlocks <- function(mat, chunk.size = 1e5,
                            by.row = TRUE, by.col = FALSE) {
  message("Using chunk size: ", chunk.size)
  if (by.row) {
    message("Breaking into row chunks.")
    return(split(1:nrow(mat), ceiling(seq_along(1:nrow(mat))/chunk.size)))
  }
  
  #assumes column-wise chunking
  message("Breaking into column chunks.")
  return(split(1:ncol(mat), ceiling(seq_along(1:ncol(mat))/chunk.size)))
}

#' Convert a sparse matrix to a dense matrix in a block-wise fashion 
#' 
#' @name sparseToDenseMatrix
#'
#' @param mat Input sparse matrix
#' @param blockwise Whether to do the coercion in a block-wise manner
#' @param by.row Whether to chunk in a row-wise fashion
#' @param by.col Whether to chunk in a column-wise fashion
#' @param chunk.size The size of the chunks to use for coercion
#' @param parallel Whether to perform the coercion in parallel
#' @param cores The number of cores to use in the parallel coercion
#'
#' @return A dense matrix of the same dimensions as the input
#' 
#' @import Matrix
#' @import parallel
#' 
#' @export 
#' 
#' @examples
#' #make a sparse binary matrix
#' library(Matrix)
#' m <- 100
#' n <- 1000
#' mat <- round(matrix(runif(m*n), m, n))
#' mat.sparse <- Matrix(mat, sparse = TRUE)
#' 
#' #coerce back
#' mat.dense <- sparseToDenseMatrix(mat.sparse, chunk.size = 10)
#' 
#' #make sure they are the same dimensions
#' dim(mat) == dim(mat.dense)
#' 
#' #make sure they are the same numerically
#' all(mat == mat.dense)

sparseToDenseMatrix <- function(mat, blockwise = TRUE,
                                by.row = TRUE, by.col = FALSE,
                                chunk.size = 1e5, parallel = FALSE,
                                cores = 2) {
  if (isFALSE(blockwise)) return(as(mat, "matrix"))
  
  #do block-wise reconstruction of matrix
  chunks <- getMatrixBlocks(mat, chunk.size = chunk.size,
                            by.row = by.row, by.col = by.col)
  
  if (by.row & parallel) {
    return(do.call("rbind", mclapply(chunks, function(r) {
      return(as(mat[r,], "matrix"))
    }, mc.cores = cores)))
  }
  
  if (by.row & !parallel) {
    return(do.call("rbind", lapply(chunks, function(r) {
      return(as(mat[r,], "matrix"))
    })))
  }
  
  #assumes column-wise conversion
  if (by.col & parallel) {
    return(do.call("cbind", mclapply(chunks, function(r) {
      return(as(mat[,r], "matrix"))
    }, mc.cores = cores)))
  }
  
  return(do.call("cbind", lapply(chunks, function(r) {
    return(as(mat[,r], "matrix"))
  })))
  
}