# Description

The MicroMetaGraph R package, when given a set of input dataset of genes/proteins, will construct an interaction network using orthology data, functional annotations and PPI data from various metatranscriptomic databases. When analyzing microbial communities or any environment where PPI are a crucial factor, oftentimes there will be proteins present with an unknown function or that belongs to a species that has not yet been sequenced. Therefore, interaction networks including these unknown proteins aid in the interpretation of the protein's role could be, and have been very popular in metatranscriptomic workflows in the past. While there have been R packages that are able to return interaction data about an input protein and construct interaction networks in the past, there is not one that has incorpoorated the structure of orthologous groups. Thus, with the MicroMetaGraph package, viewing interaction networks in the context of orthologous groups provides a novel insight into the functional scope between the input proteins 

# Installation

To download the pacakge:
  require("devtools")
  devtools::install_github("emilyso-99/MicroMetaGraph",build_vignette = TRUE)
  library("MicroMetaGraph")

# Overview: 

# Contributions

# References 

