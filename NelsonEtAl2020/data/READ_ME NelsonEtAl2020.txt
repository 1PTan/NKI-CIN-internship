Obtaining and formating data for Nelson et al. 2020
"A living biobank of ovarian cancer ex vivo models reveals profound mitotic heterogeneity"

scRNA-seq data, barcode and study metadata were downloaded from The Single Cell Expression Atlas https://www.ebi.ac.uk/gxa/sc/home
These files should be placed on the "data" directory.

Title: Single cell RNA-seq from 10X for a living biobank of ovarian cancer ex vivo models reveals profound mitotic heterogeneity
ID: E-MTAB-8559
Link: https://www.ebi.ac.uk/gxa/sc/experiments/E-MTAB-8559/results/tsne

The scRNA-seq data is imported in the "NelsonEtAl2020_setup.Rmd" script using the Seurat Read10X function.
To this end, it should be renamed, compressed and placed into the "data/data_10x_format" folder.

This folder should contain 3 files, compressed with gunzip ".gz":
1) "matrix.mtx.gz" containing the matrix of molecular counts. Corresponds to "E-MTAB-8559.aggregated_filtered_counts.mtx"
2) "features.tsv.gz" containing the feature names. Corresponds to "E-MTAB-8559.aggregated_filtered_counts.mtx_rows"
3) "barcodes.tsv.gz" containing the barcode identifiers. Corresponds to "E-MTAB-8559.aggregated_filtered_counts.mtx_cols"