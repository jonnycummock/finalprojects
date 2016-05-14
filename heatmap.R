---
  title: "Final Project"
author: "Jonathon cummock"
date: "May 13, 2016"
output:
  Rmd_document:
  variant: markdown_github
toc: true
toc_depth: 2
---
  
  # Overview - I will use original rna-seq data to generate a heatmap to compare gene regulation between control and cancer subjects
  
```{r library, message=FALSE, warning=FALSE}
library(readr)
library(tidyr)
library(dplyr)
library(stringr)
library(gplots)

#separate(key, into = c('Gene', 'Common_name', 'Treatment_mean', 'Fold_change', 'P-value', 'Q-value', 'Control', '051314_HLADR', '061814_HLADR', '062014_HLADR', 'Treatment', '051314_CD14', '052614_CD14', '061814_CD14', '062014_CD14'), sep = " ") %>%
  

genes_tidy <- genes %>% mutate(obs = seq_len(n())) %>% tbl_df %>% gather(key, value, -obs) %>%
  separate(key, into = c('var', 'set', sep = " ")) %>%
  spread(var, value) %>%
  arrange(set)

#the key is all the columns, and it keeps the values;

data_genes_tidy <- data.matrix(genes_tidy)
?heatmap.2

gr <- colorRampPalette(c("green", "red"))
heatmap.2(data_genes_tidy, col = gr, main = "Heatmap of CD14 and CD15 gene expression", trace = "none", margins = c(10,12), cexRow = 0.5)


#heatmap(data.matrix(genes_tidy), scale="column", col=heat.colors(256), main = "Heatmap of CD14 and CD15 gene expression", Rowv = NA, Colv = NA)
