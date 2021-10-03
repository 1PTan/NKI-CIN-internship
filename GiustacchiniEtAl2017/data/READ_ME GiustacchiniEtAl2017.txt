Obtaining and formating data for GiustacchiniEtAl2017
"Single-cell transcriptomics uncovers distinct molecular signatures of stem cells in chronic myeloid leukemia"

scRNA-seq data, barcode and study metadata were downloaded from The Single Cell Expression Atlas https://www.ebi.ac.uk/gxa/sc/home
These files should be placed on the "data" directory.

Title: Single cell RNA-seq of cancer stem cells from patients with chronic myeloid leukemia during the disease course
ID: E-GEOD-76312
Link: https://www.ebi.ac.uk/gxa/sc/experiments/E-GEOD-76312/results/tsne

The scRNA-seq data is imported in the "GiustacchiniEtAl2017_setup.Rmd" script using the Seurat Read10X function.
To this end, it should be renamed, compressed and placed into the "data/data_10x_format" folder.

This folder should contain 3 files, compressed with gunzip ".gz":
1) "matrix.mtx.gz" containing the matrix of molecular counts. Corresponds to "E-GEOD-76312.aggregated_filtered_counts.mtx"
2) "features.tsv.gz" containing the feature names. Corresponds to "E-GEOD-76312.aggregated_filtered_counts.mtx_rows"
3) "barcodes.tsv.gz" containing the barcode identifiers. Corresponds to "E-GEOD-76312.aggregated_filtered_counts.mtx_cols"