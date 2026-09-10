cran <- c("missMDA", "FactoMineR")
bioc <- c("limma", "DESeq2")
m <- cran[!vapply(cran, requireNamespace, logical(1), quietly = TRUE)]
if (length(m)) install.packages(m, repos = "https://cloud.r-project.org")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager", repos = "https://cloud.r-project.org")
m <- bioc[!vapply(bioc, requireNamespace, logical(1), quietly = TRUE)]
if (length(m)) BiocManager::install(m, ask = FALSE, update = FALSE)

