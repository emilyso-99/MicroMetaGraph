context("annotation")

test_that("annotation with one invalid protein", {
  
  input_ids <- c("Protein 1")
  expected <- data.frame(GenBankID=character(),OG= character())
  expected<- add_row(expected,GenBankID="Protein 1",OG="None")
  expect_equal(GetOrthology(input_ids),expected)
})

test_that("annotation with one valid protein", {
  
  input_orthologs <- c("MA_0581")
  expected <- data.frame(GenBankID=character(),OG= character())
  expected<- add_row(expected,GenBankID="MA_0581",OG="COG0001")
  expect_equal(GetOrthology(input_orthologs),expected)
  
})

test_that("annotation with one valid protein, and one invalid", {
  
  input_orthologs <- c("MA_0581", "Protein 2")
  expected <- data.frame(GenBankID=character(),OG= character())
  expected<- add_row(expected,GenBankID="MA_0581",OG="COG0001")
  expected<- add_row(expected,GenBankID="Protein 2",OG="None")
  expect_equal(GetOrthology(input_orthologs),expected)
})
test_that("two invalid proteins", {
  
  input_orthologs <- c("Protein 1", "Protein 2")
  expected <- data.frame(GenBankID=character(),OG= character())
  expected<- add_row(expected,GenBankID="Protein 1",OG="None")
  expected<- add_row(expected,GenBankID="Protein 2",OG="None")
  expect_equal(GetOrthology(input_orthologs),expected)
})
