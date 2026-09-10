# Methods and code alignment notes

## Decisions reproduced from the supplied code

The original Fig. 1e script performs two operations not stated explicitly in
the current Methods:

1. For each protein and tissue, all replicate values are set to missing when
   the protein is detected in no more than one replicate.
2. The detected replicate abundances retained after that filter are averaged
   before the tissue-level classification.

Script `02_fig1e_enriched_enhanced.R` reproduces this behavior.

## Decisions requiring author confirmation

### Enhanced denominator

The supplied code calculates:

`tissue abundance / mean abundance across all detected tissues`

and includes the focal tissue in the denominator. This makes a five-fold
threshold mathematically impossible when a protein is detected in five or
fewer tissues, unless some detected values are zero. Confirm whether the
intended definition instead uses the mean of all *other* tissues. If so,
change the denominator before release and revise the Methods and figure legend.

### PCA scope

The supplied code performs one PCA across all tissues for each pairwise
comparison and then performs tissue-wise Welch tests on the resulting global
PC1 and PC2 scores. The refactored script preserves that order.

### Multiple testing for PCA

The manuscript defines significance as nominal P < 0.01 for PC1 or PC2. The
script retains this flag and additionally reports BH-adjusted P values across
all tissue-component tests. The manuscript should identify the nominal analysis
as exploratory or state which multiplicity correction is inferentially primary.

### Pathway redundancy

The supplied code filters adjusted P <= 0.01, sorts pathways by Count
descending, and greedily retains a pathway only when its overlap coefficient
with every retained pathway is below 0.9. The coefficient is
`|A intersect B| / min(|A|, |B|)`. The refactor preserves this algorithm.

## Recommended Methods sentence

> For tissue-level summary analyses, protein measurements detected in only one
> replicate of a tissue were treated as missing. For proteins detected in at
> least two replicates, the mean abundance across detected replicates was used
> for downstream tissue-level analyses.
