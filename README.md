# Multi-Tissue Cell Membrane Proteomic Profiling of Metabolic Disease Progression and Exercise in Mice Identifies Hypothalamic GPCR Regulators of Energy Balance

This repository provides selected R scripts and analysis workflows associated with our study of cell membrane protein (CMP) remodeling across mouse tissues during metabolic disease progression and exercise intervention.

## About the study

In this study, we constructed a multi-tissue CMP proteomic atlas across 22 tissues from male mice and profiled CMP proteomic and transcriptomic changes across metabolically relevant tissues in mouse models of obesity, type 2 diabetes, and exercise intervention. The study characterizes tissue-specific CMP remodeling, with a particular focus on GPCRs, receptor tyrosine kinases (RTKs), and their associated protein ligands/prohormones, and identifies hypothalamic PTH1R and PTH2R as regulators of feeding, body weight, and exercise-associated metabolic adaptation.

## Article

**Current manuscript title:**  
*Multi-Tissue Cell Membrane Proteomic Profiling of Metabolic Disease Progression and Exercise in Mice Identifies Hypothalamic GPCR Regulators of Energy Balance*

**Preprint:**  
Lang X. et al. *Cell membrane proteome profiling uncovers molecular signatures and GPCR regulators underlying diet-induced obesity and exercise-mediated adaptation.*  
https://doi.org/10.64898/2026.04.23.720492

## Code in this repository

The repository contains example R scripts for selected analyses described in the manuscript.

| Script | Analysis |
|---|---|
| `01_fig1d_cv.R` | Replicate-level coefficient of variation analysis (Fig. 1d) |
| `02_fig1e_enriched_enhanced.R` | Tissue-enriched and tissue-enhanced CMP analysis (Fig. 1e) |
| `03_fig3e_pca_ttest.R` | PCA and statistical testing of PC1/PC2 scores (Fig. 3e) |
| `04_fig3f_limma_decmp.R` | Processing and integration of differential CMP analysis results (Fig. 3f) |
| `05_fig3f_tissue_specific_shared.R` | Tissue-specific and tissue-shared differential CMP analysis (Fig. 3f) |
| `06_fig4d_reverse_trend.R` | Reverse-trend CMP analysis and restoration index calculation (Fig. 4d) |
| `07_fig4e_pathway_redundancy.R` | Redundancy filtering for pathway enrichment results (Fig. 4e) |
| `08_si_fig5d_deseq2.R` | DESeq2-based transcriptomic analysis (Supplementary Fig. 5d) |

## Running the example code

R >= 4.2 is recommended.

```bash
Rscript install_dependencies.R
Rscript run_example.R
```

Individual scripts can also be run separately as needed.

## Data availability

Proteomics data generated in this study have been deposited in iProX under dataset identifier **IPX0011997000**. Transcriptomics data have been deposited in the CNGB Sequence Archive (CNSA) under project **CNP0007469**. Please refer to the manuscript for detailed data-access information.

## Notes

The code provided here is intended as example/reference code for selected customized analyses and does not constitute a complete end-to-end reproduction of every analysis in the study. Most analyses were performed using established open-source R packages.

For complete information on data processing, statistical analysis, parameter settings, thresholds, and software used in the study, please refer to the **Methods** section of the manuscript.
