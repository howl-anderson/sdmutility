test_that("get kappa", {
    library("raster")
    
    current.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    current.layer[] <- c(1,1,0,1,1,0,1,0,0)
    
    future.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    future.layer[] <- c(0,1,1,1,1,1,0,1,0)
    
    cm <- confusionMatrix(current.layer, future.layer)
    kappa.score <- getKappa(cm)
})
