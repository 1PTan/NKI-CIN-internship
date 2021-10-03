Obtaining and formating data for Chung et al. 2017
"Single-cell RNA-seq enables comprehensive tumour and immune cell profiling in primary breast cancer"

scRNA-seq data, barcode and study metadata were downloaded from The Single Cell Expression Atlas https://www.ebi.ac.uk/gxa/sc/home
These files should be placed on the "data" directory.

Title: Single cell RNA-seq of primary breast cancer cells and lymph node metastases from 11 patients representing 
the four subtypes of breast cancer: luminal A, luminal B, HER2 and triple negative breast cancer
ID: E-GEOD-75688
Link: https://www.ebi.ac.uk/gxa/sc/experiments/E-GEOD-75688/results/tsne

The scRNA-seq data is imported in the "ChungEtAl2017_setup.Rmd" script using the Seurat Read10X function.
To this end, it should be renamed, compressed and placed into the "data/data_10x_format" folder.

This folder should contain 3 files, compressed with gunzip ".gz":
1) "matrix.mtx.gz" containing the matrix of molecular counts. Corresponds to "E-GEOD-75688.aggregated_filtered_counts.mtx"
2) "features.tsv.gz" containing the feature names. Corresponds to "E-GEOD-75688.aggregated_filtered_counts.mtx_rows"
3) "barcodes.tsv.gz" containing the barcode identifiers. Corresponds to "E-GEOD-75688.aggregated_filtered_counts.mtx_cols"