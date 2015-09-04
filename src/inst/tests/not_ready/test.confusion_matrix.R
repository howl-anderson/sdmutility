test_that("confusion matrix", {    
    current.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    current.layer[] <- c(1,1,0,1,1,0,1,0,0)
    
    future.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    future.layer[] <- c(0,1,1,1,1,1,0,1,0)
    
    confusion.matrix <- confusionMatrix(current.layer, future.layer)
    
    standard.confusion.matrix <- list(tp=3, fp=3, fn=2, tn=1)
    attr(standard.confusion.matrix, "class") <- "ConfusionMatrix"
    
    expect_equal(standard.confusion.matrix, confusion.matrix)
})
