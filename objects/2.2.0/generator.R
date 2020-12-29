library(iSEE)
for (class in c("ReducedDimensionPlot", "FeatureAssayPlot", "ColumnDataPlot", "RowDataPlot", "ComplexHeatmapPlot", "SampleAssayPlot", "RowDataTable", "ColumnDataTable")) {
    saveRDS(file=paste0(class, ".rds"), new(class))
}
