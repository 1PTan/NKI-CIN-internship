Obtaining and formating data for Tirosh et al. 2016
"Dissecting the multicellular ecosystem of metastatic melanoma by single-cell RNA-seq"

scRNA-seq data , barcode and study metadata  were downloaded from Gene Expression Omnibus https://www.ncbi.nlm.nih.gov/geo/

Title: Single cell RNA-seq analysis of melanoma
ID: GSE72056
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE72056
("GSE72056_melanoma_single_cell_revised_v2.txt.gz") ("Series Matrix File" > "GSE72056_series_matrix.txt.gz")

These files should be placed on the "data" directory.
The count matrix should be decompressed from the gunzip format ".gz"

The scRNA-seq data is imported in the "TiroshEtAl2016_setup.Rmd" script 
The metadata is read using the GEOquery getGEO function.