Obtaining and formating data for Karaayvaz et al. 2018
"Unravelling subclonal heterogeneity and aggressive disease states in TNBC through single-cell RNA-seq"

scRNA-seq data , barcode and study metadata  were downloaded from Gene Expression Omnibus https://www.ncbi.nlm.nih.gov/geo/

Title: Unravelling subclonal heterogeneity and aggressive disease states in TNBC through single-cell RNA-seq
ID: GSE118390
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE118390
      https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE118389
	("GSE118389_counts_rsem.txt.gz") ("Series Matrix File" > "GSE118389_series_matrix.txt.gz")

These files should be placed on the "data" directory.

The count matrix should be decompressed from the gunzip format ".gz"

Celltype metadata "cell_types_S9.txt" was obtained from Github https://github.com/Michorlab/tnbc_scrnaseq

The scRNA-seq data is imported in the "KaraayvazEtAl2018_setup.Rmd" script 
The metadata is read using the GEOquery getGEO function.