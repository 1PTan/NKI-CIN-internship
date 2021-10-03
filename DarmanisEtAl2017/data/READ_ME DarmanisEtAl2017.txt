Obtaining and formating data for Darmanis et al. 2017
"Single-Cell RNA-Seq Analysis of Infiltrating Neoplastic Cells at the Migrating Front of Human Glioblastoma"

scRNA-seq data , barcode and study metadata  were downloaded from Gene Expression Omnibus https://www.ncbi.nlm.nih.gov/geo/

Title: Single-Cell RNAseq analysis of diffuse neoplastic infiltrating cells at the migrating front of human glioblastoma
ID: GSE84465
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE84465
("GSE84465_GBM_All_data.csv.gz") ("Series Matrix File" > "GSE84465_series_matrix.txt.gz")

These files should be placed on the "data" directory.

The count matrix should be decompressed from the gunzip format ".gz"

The scRNA-seq data is imported in the "DarmanisEtAl2017_setup.Rmd" script 
The metadata is read using the GEOquery getGEO function.

Additional metadata was obtained from the Single Cell Expression Atlas https://www.ebi.ac.uk/gxa/sc/home
These files should be placed on the "data" directory.

Title: Single-Cell RNAseq analysis of diffuse neoplastic infiltrating cells at the migrating front of human glioblastoma
ID: E-GEOD-84465
Link: https://www.ebi.ac.uk/gxa/sc/experiments/E-GEOD-84465/results/tsne