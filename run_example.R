scripts <- c("01_fig1d_cv.R", "02_fig1e_enriched_enhanced.R",
  "03_fig3e_pca_ttest.R", "04_fig3f_limma_decmp.R",
  "05_fig3f_tissue_specific_shared.R", "06_fig4d_reverse_trend.R",
  "07_fig4e_pathway_redundancy.R", "08_si_fig5d_deseq2.R")
dir.create("example_results", showWarnings = FALSE)
for (s in scripts) {
  message("Running ", s)
  status <- system2(file.path(R.home("bin"), "Rscript"), file.path("code", s))
  if (status != 0) stop("Failed: ", s)
}
writeLines(capture.output(sessionInfo()), "example_results/sessionInfo.txt")
message("All example analyses completed.")
