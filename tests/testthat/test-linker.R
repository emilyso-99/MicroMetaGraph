context("linker")
library(tibble)
test_that("linking with one invalid ortholog", {
  
  input_orthologs <- c("Group 2")
  expected <- 1
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})

test_that("annotation with one valid ortholog group, should not connect to
          anything", {
  
  input_orthologs <- c("COG0001")
  expected <- 0
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
  
})

test_that("annotation with one valid ortholog group, and one invalid", {
  
  input_orthologs <- c("COG0001","COG2")
  expected <- 1
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})
test_that("two invalid orthologs", {
  
  input_orthologs <- c("COG0001", "COG0006")
  expected <- 2
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})

