# Test_evaluatePrecision.numeric <- function() {
#     predict_value <- c(0.2, 0.5, 0.4, 0.5)
#     observed_value <- c(0, 1, 0, 1)
#     threshold <- 0.5
#
#     evaluatePrecision(observed_value, predict_value, threshold)
# }

# Test_evaluatePrecision.RasterLayer <- function() {
#     size <- 2
#     r <- raster(nrow=size, ncol=size, xmn=0.5,
#                 xmx=(size+0.5), ymn=0.5, ymx=(size+0.5), crs=NA)
#     r[] <- c(0.2, 0.5, 0.4, 0.5)
#     predict_value <- r
#
#     r <- raster(nrow=size, ncol=size, xmn=0.5,
#                 xmx=(size+0.5), ymn=0.5, ymx=(size+0.5), crs=NA)
#     r[] <- c(0, 1, 0, 1)
#     observed_value <- r
#
#     threshold <- 0.45
#
#     evaluatePrecision(observed_value, predict_value, threshold)
# }
