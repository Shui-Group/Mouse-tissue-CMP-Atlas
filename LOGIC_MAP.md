# Original-to-refactored logic map

This file records what was retained from each supplied script.

## Fig1d CV calculation

- CV is calculated on linear abundance as SD divided by mean.
- Protein-tissue observations require at least two non-missing replicates.
- Zero means are excluded.
- CMP and ligand/prohormone sets are calculated separately; overlap is allowed.

## Fig1e Tissue enriched calculation

- Tissue-protein combinations detected in at most one replicate are set missing.
- Remaining detected replicates are averaged.
- Enhanced uses abundance divided by the mean of detected tissue abundances.
- Threshold is five-fold.
- Pairs already classified as enriched are removed from enhanced.

The supplied file reads the enriched set from an upstream RDS object. Its
upstream generation is only present as commented code; therefore confirm that
the active enriched definition used for the final figure is the maximum versus
second maximum five-fold rule represented in the refactor.

## Fig3f PCA t test

- Retain CMPs and DIA-NN/Both measurements.
- Apply `log1p`.
- Set seed 666 and apply `imputePCA(..., ncp = 2)`.
- For each pairwise comparison, fit one scaled PCA across all tissues.
- Within each tissue, run two-sided unequal-variance t-tests on Dim.1 and Dim.2.
- Record the original 0.05 and 0.01 pass labels without adding a new correction.

## Fig3f DECMP

- The supplied script begins with precomputed limma result tables.
- Keep `|logFC| >= log2(1.25)` and adjusted P <= 0.05, or a non-missing
  `Only` label.
- Restrict to annotated CMPs.
- Retain all selected DIA-NN rows and append only Spectronaut-exclusive rows.
- Assign up/down using logFC or the group-specific `Only` label.

## Fig3f Tissue specific and shared

- Construct the equivalent protein-by-tissue membership table for each
  comparison and direction.
- Count occurrence in 1, 2, 3, 4, or at least 5 tissues.
- One tissue is tissue-specific; more than one is tissue-shared.

## Fig4d Reverse and restoration

- Reverse proteins are Obs/Chow up plus Exe/Obs down, or Obs/Chow down plus
  Exe/Obs up, within the same tissue.
- Restoration index is `abs((Exe - Obs)/(Obs - Chow))` from group-average
  abundance.
- Complete reverse is restoration index >= 0.8.

## Fig4e Pathway redundancy

- Filter adjusted P <= 0.01 and non-empty geneID.
- Sort Count descending.
- Split geneID on `/`.
- Greedily retain the largest pathway.
- Delete a later pathway when overlap coefficient with any retained pathway is
  at least 0.9.

## Supplementary Fig5 RNAseq DESeq2

- Input is an unnormalized integer count matrix.
- Keep genes with counts >= 10 in at least three samples.
- Use design `~ group`, DESeq2 normalization and model fitting.
- The publication threshold is adjusted P < 0.05 and absolute fold change >1.5,
  with the supplied exclusive-detection rule retained in the output.

