# This tests changes in the labelling functionality.
# library(testthat); library(iSEE); source("test_DotPlot_Labels.R")

dotplots <- c("ColumnDataPlot", "RowDataPlot", "ReducedDimensionPlot", "FeatureAssayPlot", "SampleAssayPlot")
of.interest <- c(
    file.path("2.0.0", dotplots)
)

of.interest <- file.path("../objects", paste0(of.interest, ".rds"))

test_that("New label-related getters work correctly", {
    for (obj in of.interest) {
        x <- readRDS(obj)

        expect_warning(out <- x[["HoverInfo"]], "outdated")
        expect_true(out)

        expect_warning(out <- x[["LegendPointSize"]], "outdated")
        expect_identical(out, 1)

        expect_warning(out <- x[["LabelCenters"]], "outdated")
        expect_false(out)

        expect_warning(out <- x[["LabelCentersBy"]], "outdated")
        expect_identical(out, NA_character_)

        expect_warning(out <- x[["LabelCentersColor"]], "outdated")
        expect_identical(out, "black")

        expect_warning(out <- x[["CustomLabels"]], "outdated")
        expect_false(out)

        expect_warning(out <- x[["CustomLabelsText"]], "outdated")
        expect_identical(out, NA_character_)
    }
})

test_that("New label-related setters work correctly", {
    for (obj in of.interest) {
        x <- readRDS(obj)

        test <- x
        expect_warning(test[["HoverInfo"]] <- FALSE, "outdated")
        expect_false(test[["HoverInfo"]])

        test <- x
        expect_warning(test[["LegendPointSize"]] <- 2, "outdated")
        expect_identical(test[["LegendPointSize"]], 2)

        test <- x
        expect_warning(test[["LabelCenters"]] <- TRUE, "outdated")
        expect_true(test[["LabelCenters"]])

        test <- x
        expect_warning(test[["LabelCentersBy"]] <- "AAA", "outdated")
        expect_identical(test[["LabelCentersBy"]], "AAA")

        test <- x
        expect_warning(test[["LabelCentersColor"]] <- "red", "outdated")
        expect_identical(test[["LabelCentersColor"]], "red")

        test <- x
        expect_warning(test[["CustomLabels"]] <- TRUE, "outdated")
        expect_true(test[["CustomLabels"]])

        test <- x
        expect_warning(test[["CustomLabelsText"]] <- "A", "outdated")
        expect_identical(test[["CustomLabelsText"]], "A")
    }
})
