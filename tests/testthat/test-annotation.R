context("annotation")

test_that("annotation with one invalid ortholog", {
  
  input_orthologs <- c("Group 1")
  expected <- tibble("OG"=character(),"description"=character())
  expected<- add_row(expected,OG="Group 1",description="None")
  expect_equal(FunctionalAnnotation(input_orthologs),expected)
})

test_that("annotation with one valid ortholog group", {
  
  input_orthologs <- c("COG0001")
  expected <- tibble("OG"=character(),"description"=character())
  expected<- add_row(expected,OG="COG0001",description="Coenzyme transport and metabolism")
  expect_equal(FunctionalAnnotation(input_orthologs),expected)
  
})

test_that("annotation with one valid ortholog group, and one invalid", {
  
  input_orthologs <- c("COG0001", "Group 2")
  expected <- tibble("OG"=character(),"description"=character())
  expected<- add_row(expected,OG="COG0001",description="Coenzyme transport and metabolism")
  expected<- add_row(expected,OG="Group 2",description="None")
  expect_equal(FunctionalAnnotation(input_orthologs),expected)
})
test_that("two invalid orthologs", {
  
  input_orthologs <- c("Group 1", "Group 2")
  expected <- tibble("OG"=character(),"description"=character())
  expected<- add_row(expected,OG="Group 1",description="None")
  expected<- add_row(expected,OG="Group 2",description="None")
  expect_equal(FunctionalAnnotation(input_orthologs),expected)
})

