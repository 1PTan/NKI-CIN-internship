Obtaining and formating data for Puram et al. 2017
"Single-Cell Transcriptomic Analysis of Primary and Metastatic Tumor Ecosystems in Head and Neck Cancer"

scRNA-seq data , barcode and study metadata  were downloaded from Gene Expression Omnibus https://www.ncbi.nlm.nih.gov/geo/

Title: Single cell RNA-seq analysis of head and neck cancer
ID: GSE103322
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE103322
("GSE103322_HNSCC_all_data.txt.gz") ("Series Matrix File" > "GSE103322_series_matrix.txt.gz")

These files should be placed on the "data" directory.
The count matrix should be decompressed from the gunzip format ".gz"

The scRNA-seq data is imported in the "PuramEtAl2017_setup.Rmd" script 
The metadata is read using the GEOquery getGEO function.