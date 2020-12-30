# This just checks that all updateObject functions run correctly.
# library(testthat); library(iSEE); source("test_update.R")

of.interest <- list.files("../objects", recursive=TRUE, pattern=".rds$", full=TRUE)

test_that("updateObject runs correctly", {
    for (obj in of.interest) {
        old <- readRDS(obj)
        expect_warning(out <- updateObject(old), "outdated")
        expect_identical(class(out), class(old))
        expect_true(validObject(out))
    }
})
