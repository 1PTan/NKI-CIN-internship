# NKI-CIN-internship
This repository contains the code used for the Bioinformatics Major Internship from Pedro Batista Tan
at the Netherlands Cancer Institute, from the Bioinformatics and Systems Biology program at the
Vrije Universiteit Amsterdam (VU) and Universiteit van Amsterdam (UvA). This internship was supervised by Michael Schubert and Lodewyk Wessels from the computational cancer biology group at the Netherlands Cancer Institute (NKI).

The goal of this project was to determine gene expression changes associated with chromosomal instability in cancer cells. 
For more detailed information on the project, see the final internship report "Bioinformatics Major Report NKI CIN Pedro Tan Final.pdf".

(0) The following scripts should be run first to setup necessary files:
0.1) "Get_msigdb_hallmarks.Rmd"
Queries hallmark gene sets from the msigdbr package. 
Creates csv files for human "msigdb_hallmarks_set.csv" and mouse "msigdb_hallmarks_set_mouse.csv". which are imported with other scripts
Also creates a file "names_hallmarks.csv" with abbreviations for pathway names.

0.2) "biomart_query_gene_features.Rmd"
queries biomaRt to obtain chromosome names, start and end position for each gene. Also maps ensembl IDs to HGNC symbols
Exports this information for all genes "biomaRt_gene_features.csv" and selects features used for inferCNV "inferCNV_gene_features.csv"
These files are also created for mouse genes "biomaRt_gene_features_mouse.csv" and "inferCNV_gene_features_mouse.csv"

0.3)"get_ensembl_db.Rmd"
Creates a csv file "EnsDb.Hsapiens.v86.csv" with ensenbml gene information from the "EnsDb.Hsapiens.v86" package


The scRNA-seq anaylsis pipeline contains the following steps:
(1) Setup seurat objects for scRNA-seq datasets
(2) Processes objects with Seurat
(3) runs inferCNV to infer copy number alterations to each cell
(4) measures the karyotype and heterogeneity for each sample
(5) assigns CIN-high and CIN-low groups based on these scores
(6) Performs differential expression using DESeq2 in pseudo bulk samples for scRNA-seq data, comparing CIN-high x CIN-low
(7) Performs gene set enrichment analysis in differential expression results, using the Molecular Signatures Database Hallmark gene sets

Each dataset has a directory that should contain the scRNA-seq data. Read me files are provided with details on how to obtain the data, but these may also be requested (pedro.tan2@gmail.com, pedro.tan@outlook.com)
For step 1, setup scripts are located within each dataset folder "{dataset}/{dataset}_setup.Rmd"

For step 2, the "Process_seurat_object.Rmd" is knitted from the command line, specifying the dataset folder
Rscript -e "rmarkdown::render('Process_seurat_object.Rmd', params=list(folder= '{dataset}'), output_file = '{dataset}/{dataset}.html')"

For steps 3 and 4, the "run_inferCNV.Rmd" is knitted from the command line, specifying the dataset folder
Rscript -e "rmarkdown::render('run_inferCNV.Rmd', params=list(folder= '{dataset}'), output_file = '{dataset}/{dataset}_inferCNV.html')"

For step 5, scripts are run within each folder "{dataset}/{dataset}_CIN_assignment.Rmd"

For steps 6 and 7, the script "DESEq_pseudobulk.Rmd"  is knitted from the command line, specifying the dataset folder
Rscript -e "rmarkdown::render('DESEq_pseudobulk.Rmd', params=list(folder= '{dataset}'), output_file = '{dataset}/{dataset}_DESEq2.html')"

Bulk transcriptomics analysis
For the Bakhoum et al. 2018 dataset, scripts for bulk RNA-seq analysis are also provided
"Bakhoum_Bulk_transcriptomics_5Samples.Rmd"
Reproduces the original analysis from Bakhoum et al., using all Bulk samples and the DESeq2 normal log fold change shrinkage (done by default in the DESeq2 version used in the original analysis)

"Bakhoum_Bulk_transcriptomics_sc3Samples.Rmd"
Runs analysis of bulk results, using only the 3 samples that are also present in the scRNA-seq dataset.

"Bakhoum_CIN_DE_sc_x_sc3bulk.Rmd"
Compares results between single cell and bulk analysis


After results are obtained for all datasets, "Compare_df_genesets.Rmd" can be run to aggregate results for all datasets and "Final Figures.Rmd" to recreate the figures used in the report

