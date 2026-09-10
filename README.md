# Reproducible analysis code for the multi-tissue CMP study

This repository contains custom R analyses supporting Fig. 1d, Fig. 1e,
Fig. 3e, Fig. 3f, Fig. 4d, Fig. 4e and Supplementary Fig. 5d. The small
synthetic inputs document the schemas and exercise the analysis workflow; they
are not study results.

## Manuscript mapping

| Script | Analysis |
|---|---|
| `01_fig1d_cv.R` | Replicate-level CV (Fig. 1d) |
| `02_fig1e_enriched_enhanced.R` | Tissue enriched/enhanced CMPs (Fig. 1e) |
| `03_fig3e_pca_ttest.R` | PCA and PC1/PC2 Welch tests (Fig. 3e) |
| `04_fig3f_limma_decmp.R` | Filtering and DIA-NN/Spectronaut merging of precomputed limma outputs (Fig. 3f) |
| `05_fig3f_tissue_specific_shared.R` | Tissue-specific/shared DECMPs (Fig. 3f) |
| `06_fig4d_reverse_trend.R` | Reverse-trend DECMPs (Fig. 4d) |
| `07_fig4e_pathway_redundancy.R` | Count-prioritized overlap-coefficient redundancy removal (Fig. 4e) |
| `08_si_fig5d_deseq2.R` | DESeq2 analysis (Supplementary Fig. 5d) |

## Input data

Replace `example_data/proteomics_long.csv` with the sample-level processed
abundance report deposited in iProX. Replace the RNA-seq example matrices with
the raw count matrix deposited in CNSA/Supplementary Data. Before publication,
add the exact repository URLs and filenames here.

Required proteomics input columns:

`protein_group,gene,tissue,group,replicate,abundance,is_cmp`

Fig. 1d additionally uses `protein_annotation.csv` to identify CMPs and
ligand/prohormone proteins. As in the supplied source, a protein may contribute
to both groups when the annotations overlap.

Abundances must be positive normalized protein abundances on the linear scale.
Blank fields and `NA` are treated as missing. Group labels are `Normal`,
`Chow`, `Obs`, `Exe`, and `T2D`.

RNA-seq counts have genes in rows and sample IDs in columns. RNA metadata
contain `sample_id,tissue,group,replicate`.

## Install and run

R >= 4.2 is recommended.

```bash
Rscript install_dependencies.R
Rscript run_example.R
```

Outputs are written to `example_results/`. Each script can also be run
individually from the repository root.

## Prespecified definitions

- For the Fig. 1e tissue summaries, a protein detected in only one replicate of
  a tissue is treated as missing. Retained detected replicates are averaged.
- Enriched: the largest tissue mean is at least five-fold above the
  second-largest detected tissue mean. A protein detected in only one tissue
  has an infinite ratio and is enriched.
- Enhanced: a tissue mean is at least five-fold above the mean across all
  detected tissues for that protein. The focal tissue is included in that mean,
  matching the supplied source code. Enriched pairs take precedence.
- A conventional DECMP has `abs(log2FC) >= log2(1.25)` and BH-adjusted
  `P < 0.05`.
- A detected/undetected DECMP is detected in at least two replicates of one
  group and zero replicates of the other. Its direction is retained, but P
  values are `NA` because this rule is separate from limma.
- Tissue-specific means significant in exactly one tissue in a comparison;
  tissue-shared means significant in two or more tissues.
- Reverse-trend means present in both Obs vs Chow and Exe vs Obs in the same
  tissue with opposite directions. Restoration index is
  `abs((Exe - Obs)/(Obs - Chow))`; RI >= 0.8 is complete reverse.
- For each pairwise comparison, PCA is fitted jointly across all tissues.
  Two-sided Welch tests are then applied to PC1 and PC2 scores within tissue.
- Pathways are filtered at adjusted P <= 0.01, sorted by Count in descending
  order, and greedily removed when their overlap coefficient with any retained
  pathway is >= 0.9.

## Methods clarification

The supplied Fig. 1e code filters tissue-protein combinations detected in only
one replicate and then averages retained repeats. This is not explicit in the
current manuscript. If intended, add:

> For tissue-level summary analyses, protein measurements detected in only one
> replicate of a tissue were treated as missing. For proteins detected in at
> least two replicates, the mean abundance across detected replicates was used
> for downstream tissue-level analyses.

The supplied enhanced rule includes the focal tissue in the across-tissue mean.
Confirm that this is the intended definition before publication.
