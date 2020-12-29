# This tests the faceting capabilities for all versions of objects.
# library(iSEE); library(testthat); source("test_facet.R")

of.interest <- c(
    file.path("2.2.0", c("ColumnDataPlot", "RowDataPlot", "ReducedDimensionPlot", "FeatureAssayPlot", "SampleAssayPlot"))
)

test_that("Old faceting getters work correctly", {
    for (obj in of.interest) {
        old <- readRDS(file.path("objects", paste0(obj, ".rds")))

        expect_warning(out <- old[["FacetByRow"]], "FacetByRow")
        expect_identical(out, "---")

        expect_warning(out <- old[["FacetByColumn"]], "FacetByColumn")
        expect_identical(out, "---")

        test <- old
        slot(test, "FacetByRow", check=FALSE) <- "WHEE"
        expect_warning(out <- test[["FacetByRow"]], "FacetByRow")
        expect_identical(out, "WHEE")

        test <- old
        slot(test, "FacetByColumn", check=FALSE) <- "BLAH"
        expect_warning(out <- test[["FacetByColumn"]], "FacetByColumn")
        expect_identical(out, "BLAH") 
    }
})

test_that("New faceting getters work correctly", {
    for (obj in of.interest) {
        old <- readRDS(file.path("objects", paste0(obj, ".rds")))

        test <- old
        slot(test, "FacetByRow", check=FALSE) <- "WHEE"
        if (.multiSelectionDimension(old)=="row") {
            expect_identical(suppressWarnings(test[["FacetRowBy"]]), "Row data")
            expect_identical(suppressWarnings(test[["FacetRowByRowData"]]), "WHEE")
        } else {
            expect_identical(suppressWarnings(test[["FacetRowBy"]]), "Column data")
            expect_identical(suppressWarnings(test[["FacetRowByColData"]]), "WHEE")
        }

        test <- old
        slot(test, "FacetByColumn", check=FALSE) <- "BLAH"
        if (.multiSelectionDimension(old)=="row") {
            expect_identical(suppressWarnings(test[["FacetColumnBy"]]), "Row data")
            expect_identical(suppressWarnings(test[["FacetColumnByRowData"]]), "BLAH")
        } else {
            expect_identical(suppressWarnings(test[["FacetColumnBy"]]), "Column data")
            expect_identical(suppressWarnings(test[["FacetColumnByColData"]]), "BLAH")
        }
    }
})

test_that("Old faceting setters work correctly", {
    for (obj in of.interest) {
        old <- readRDS(file.path("objects", paste0(obj, ".rds")))

        test <- old
        expect_warning(test[["FacetByRow"]] <- "WHEE", "FacetByRow")
        if (.multiSelectionDimension(old)=="row") {
            expect_identical(test[["FacetRowBy"]], "Row data")
            expect_identical(test[["FacetRowByRowData"]], "WHEE")
        } else {
            expect_identical(test[["FacetRowBy"]], "Column data")
            expect_identical(test[["FacetRowByColData"]], "WHEE")
        }

        test <- old
        expect_warning(test[["FacetByColumn"]] <- "BLAH", "FacetByColumn")
        if (.multiSelectionDimension(old)=="row") {
            expect_identical(test[["FacetColumnBy"]], "Row data")
            expect_identical(test[["FacetColumnByRowData"]], "BLAH")
        } else {
            expect_identical(test[["FacetColumnBy"]], "Column data")
            expect_identical(test[["FacetColumnByColData"]], "BLAH")
        }
    }
})

test_that("New faceting setters work correctly", {
    for (obj in of.interest) {
        old <- readRDS(file.path("objects", paste0(obj, ".rds")))

        test <- old
        if (.multiSelectionDimension(old)=="row") {
            expect_warning(test[["FacetRowBy"]] <- "Row selection", "outdated")
            expect_identical(test[["FacetRowBy"]], "Row selection")
        } else {
            expect_warning(test[["FacetRowBy"]] <- "Column selection", "outdated")
            expect_identical(test[["FacetRowBy"]], "Column selection")
        }

        test <- old
        if (.multiSelectionDimension(old)=="row") {
            expect_warning(test[["FacetRowByRowData"]] <- "WHEE", "outdated")
            expect_identical(test[["FacetRowByRowData"]], "WHEE")
        } else {
            expect_warning(test[["FacetRowByColData"]] <- "WHEE", "outdated")
            expect_identical(test[["FacetRowByColData"]], "WHEE")
        }

        test <- old
        if (.multiSelectionDimension(old)=="row") {
            expect_warning(test[["FacetColumnBy"]] <- "Row selection", "outdated")
            expect_identical(test[["FacetColumnBy"]], "Row selection")
        } else {
            expect_warning(test[["FacetColumnBy"]] <- "Column selection", "outdated")
            expect_identical(test[["FacetColumnBy"]], "Column selection")
        }

        test <- old
        if (.multiSelectionDimension(old)=="row") {
            expect_warning(test[["FacetColumnByRowData"]] <- "BLAH", "outdated")
            expect_identical(test[["FacetColumnByRowData"]], "BLAH")
        } else {
            expect_warning(test[["FacetColumnByColData"]] <- "BLAH", "outdated")
            expect_identical(test[["FacetColumnByColData"]], "BLAH")
        }
    }
})
