# This tests the updated selection functionality.
# library(iSEE); library(testthat); source("test_select.R")

plots <- c("ColumnDataPlot", "RowDataPlot", "ReducedDimensionPlot", "FeatureAssayPlot", "SampleAssayPlot", "ComplexHeatmapPlot")
visual.interest <- c(
    file.path("2.0.0", plots),
    file.path("2.2.0", plots)
)

tables <- c("ColumnDataTable", "RowDataTable")
base.interest <- c(
    visual.interest, 
    file.path("2.0.0", tables),
    file.path("2.2.0", tables)
)

base.interest <- file.path("../objects", paste0(base.interest, ".rds"))
visual.interest <- file.path("../objects", paste0(visual.interest, ".rds"))

test_that("old base selection getters work correctly", {
    for (obj in base.interest) {
        old <- readRDS(obj)

        expect_warning(out <- old[["ColumnSelectionSaved"]], "deprecated")
        expect_true(is.na(out))
        expect_warning(out <- old[["ColumnSelectionType"]], "deprecated")
        expect_true(is.na(out))

        expect_warning(out <- old[["RowSelectionSaved"]], "deprecated")
        expect_true(is.na(out))
        expect_warning(out <- old[["RowSelectionType"]], "deprecated")
        expect_true(is.na(out))
    }
})

test_that("old base selection setters work correctly", {
    for (obj in base.interest) {
        old <- readRDS(obj)

        test <- old
        expect_warning(test[["ColumnSelectionSaved"]] <- 1, "deprecated")
        expect_identical(test, old)

        test <- old
        expect_warning(test[["ColumnSelectionType"]] <- 1, "deprecated")
        expect_identical(test, old)

        test <- old
        expect_warning(test[["RowSelectionSaved"]] <- 1, "deprecated")
        expect_identical(test, old)

        test <- old
        expect_warning(test[["RowSelectionType"]] <- 1, "deprecated")
        expect_identical(test, old)
    }
})

test_that("new restrict selection setters work correctly", {
    for (obj in base.interest) {
        old <- readRDS(obj)

        test <- old
        expect_warning(test[["ColumnSelectionRestrict"]] <- TRUE, "outdated")
        expect_true(test[["ColumnSelectionRestrict"]])

        test <- old
        expect_warning(test[["RowSelectionRestrict"]] <- TRUE, "outdated")
        expect_true(test[["RowSelectionRestrict"]])
    }
})

test_that("old visual selection getters work correctly", {
    for (obj in visual.interest) {
        old <- readRDS(obj)

        if (!is(old, "ComplexHeatmapPlot")) {
            expect_warning(out <- old[["SelectionEffect"]], "deprecated")
            expect_identical(out, "Transparent")
        } else {
            expect_warning(out <- old[["SelectionColor"]], "deprecated")
            expect_true(is.na(out))
            expect_warning(out <- old[["SelectionEffect"]], "deprecated")
            expect_identical(out, "Color")
        }
        expect_warning(out <- old[["SelectionColor"]], "deprecated")
        expect_true(is.na(out))

        test <- old
        slot(test, "SelectionEffect", check=FALSE) <- "Restrict"
        expect_warning(out <- test[["SelectionEffect"]], "deprecated")
        expect_identical(out, "Restrict")
    }
})

test_that("new visual selection getters work correctly", {
    for (obj in visual.interest) {
        old <- readRDS(obj)

        expect_warning(out <- old[["RowSelectionRestrict"]], "outdated")
        expect_false(out)
        expect_warning(out <- old[["ColumnSelectionRestrict"]], "outdated")
        expect_false(out)

        # Seeing what happens with restrict.
        test <- old
        slot(test, "SelectionEffect", check=FALSE) <- "Restrict"
        expect_warning(outr <- test[["RowSelectionRestrict"]], "outdated")
        expect_warning(outc <- test[["ColumnSelectionRestrict"]], "outdated")

        if (.multiSelectionDimension(old)=="row") {
            expect_false(outc)
            expect_true(outr)
        } else {
            expect_true(outc)
            expect_false(outr)
        }

        if (is(old, "ComplexHeatmapPlot")) {
            expect_warning(out <- test[["ShowColumnSelection"]], "outdated")
            expect_false(out)
        }

        # Seeing what happens with another selection effect.
        test <- old
        slot(test, "SelectionEffect", check=FALSE) <- "Color"
        expect_warning(outr <- test[["RowSelectionRestrict"]], "outdated")
        expect_warning(outc <- test[["ColumnSelectionRestrict"]], "outdated")
        expect_false(outc)
        expect_false(outr)
        
        if (is(old, "ComplexHeatmapPlot")) {
            expect_warning(out <- test[["ShowColumnSelection"]], "outdated")
            expect_true(out)
        }
    }
})

test_that("old visual selection setters work correctly", {
    for (obj in visual.interest) {
        old <- readRDS(obj)

        test <- old
        expect_warning(test[["SelectionEffect"]] <- "Restrict", "deprecated")
        if (.multiSelectionDimension(old)=="row") {
            expect_true(test[["RowSelectionRestrict"]])
        } else {
            expect_true(test[["ColumnSelectionRestrict"]])
        }

        if (is(old, "ComplexHeatmapPlot")) {
            expect_false(test[["ShowColumnSelection"]])
        }

        expect_warning(test[["SelectionEffect"]] <- "Color", "deprecated")
        expect_false(test[["RowSelectionRestrict"]])
        expect_false(test[["ColumnSelectionRestrict"]])

        if (is(old, "ComplexHeatmapPlot")) {
            expect_true(test[["ShowColumnSelection"]])
        } else {
            test <- old
            expect_warning(test[["SelectionColor"]] <- "red", "deprecated")
            expect_identical(old, test)
        }
    }
})

test_that("new visual selection setters work correctly", {
    for (obj in visual.interest) {
        old <- readRDS(obj)

        test <- old
        expect_warning(test[["RowSelectionRestrict"]] <- TRUE, "outdated")
        expect_true(test[["RowSelectionRestrict"]])

        test <- old
        expect_warning(test[["ColumnSelectionRestrict"]] <- TRUE, "outdated")
        expect_true(test[["ColumnSelectionRestrict"]])
    }
})
