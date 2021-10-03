Obtaining and formating data for Lee et al. 2020
"Lineage-dependent gene expression programs influence the immune landscape of colorectal cancer"

scRNA-seq data , barcode and study metadata  were downloaded from Gene Expression Omnibus https://www.ncbi.nlm.nih.gov/geo/

KUL data
Title: Single cell 3' RNA sequencing of 6 Belgian colorectal cancer patients
ID: GSE144735
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144735
("GSE144735_processed_KUL3_CRC_10X_raw_UMI_count_matrix.txt.gz") ("GSE144735_processed_KUL3_CRC_10X_annotation.txt.gz")

CMC data
Title: Single cell 3' RNA sequencing of 23 Korean colorectal cancer patients
ID: GSE132465
Link: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE132465
("GSE132465_GEO_processed_CRC_10X_raw_UMI_count_matrix.txt.gz") ("GSE132465_GEO_processed_CRC_10X_cell_annotation.txt.gz")

These files should be placed on the "data" directory. They should be decompressed from the gunzip format ".gz"

The scRNA-seq data is imported in the "LeeEtAl2020_setup.Rmd" script.

Additional metadata was obtained from the Single Cell Expression Atlas https://www.ebi.ac.uk/gxa/sc/home
These files should be placed on the "data" directory.

Title: Single cell sequencing of colorectal tumors and adjacent non-malignant colon tissue
ID: E-MTAB-8410
Link: https://www.ebi.ac.uk/gxa/sc/experiments/E-MTAB-8410/results/tsne