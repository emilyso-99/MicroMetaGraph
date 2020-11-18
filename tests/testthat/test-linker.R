context("linker")

test_that("linking with one invalid ortholog", {
  
  input_orthologs <- c("Group 2")
  expected <- 1
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})

test_that("annotation with one valid ortholog group", {
  
  input_orthologs <- c("COG0001")
  expected <- 1886
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
  
})

test_that("annotation with one valid ortholog group, and one invalid", {
  
  input_orthologs <- c("COG0001","COG2")
  expected <- 1887
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})
test_that("two invalid orthologs", {
  
  input_orthologs <- c("COG0001", "COG0006")
  expected <- 4197
  expect_equal(nrow(CogLinker(input_orthologs,100)),expected)
})

