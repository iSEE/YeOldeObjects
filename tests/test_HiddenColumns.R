# This tests the hidden columns in the Table update.
# library(testthat); library(iSEE); source("test_HiddenColumns.R")

tables <- c("ColumnDataTable", "RowDataTable")
tab.interest <- c(
    file.path("2.0.0", tables)
)

tab.interest <- file.path("../objects", paste0(tab.interest, ".rds"))

test_that("New hidden columns getter works correctly", {
    for (obj in tab.interest) {
        x <- readRDS(obj)
        expect_warning(out <- x[["HiddenColumns"]], "updateObject")
        expect_identical(out, character(0))
    }
})

test_that("New hidden columns setter works correctly", {
    for (obj in tab.interest) {
        x <- readRDS(obj)
        expect_warning(x[["HiddenColumns"]] <- "A", "updateObject")
        expect_identical(x[["HiddenColumns"]], "A")
    }
})
