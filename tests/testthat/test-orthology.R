context("annotation")
library(tibble)
test_that("annotation with one invalid protein", {
  
  input_ids <- c("Protein 1")
  expected <- tibble(COGID=character(),EggnogID= character())
  expected<- add_row(expected,COGID="None",EggnogID="Protein 1")
  expect_equal(GetOrthology(input_ids)$OG,expected$OG)
})

test_that("annotation with one valid protein", {
  
  input_orthologs <- c("644223.PAS_chr1-1_0187")
  expected <- tibble(COGID=character(),EggnogID= character())
  expected<- add_row(expected,COGID="COG5271",EggnogID="644223.PAS_chr1-1_0187")
  expect_equal(GetOrthology(input_orthologs)$OG,expected$OG)
  
})

test_that("annotation with one valid protein, and one invalid", {
  
  input_orthologs <- c("644223.PAS_chr1-1_0187", "Protein 2")
  expected <- tibble(COGID=character(),EggnogID= character())
  expected<- add_row(expected,COGID="COG5271",EggnogID="644223.PAS_chr1-1_0187")
  expected<- add_row(expected,COGID="None",EggnogID="Protein 2")
  expect_equal(GetOrthology(input_orthologs)$OG,expected$OG)
})
test_that("two invalid proteins", {
  
  input_orthologs <- c("Protein 1", "Protein 2")
  expected <- tibble(COGID=character(),EggnogID= character())
  expected<- add_row(expected,COGID="None",EggnogID="Protein 1")
  expected<- add_row(expected,COGID="None",EggnogID="Protein 2")
  output <- GetOrthology(input_orthologs)
  expect_equal(output$OG,expected$OG)
})
