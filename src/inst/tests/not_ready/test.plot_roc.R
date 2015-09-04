test_that("plot roc", {
    library("raster")
    
    obs.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    obs.layer[] <- c(1,1,0,1,1,0,1,0,0)
    
    pred.layer <- raster(nrow=3, ncol=3, xmn=0, xmx=3, ymn=0, ymx=3, crs=NA)
    pred.layer[] <- c(2,3,3,5,6,3,3,2,2)
    
    obs.raster <- obs.layer
    pred.raster <- pred.layer
    
    roc.data <- getAuc(obs.raster, pred.raster, TRUE)
    #plotRoc(roc.data)
})
