#' @export
optimalThreshold.numeric <- function(observed_variable, predicted_variable) {
    data <- cbind(1, observed_variable, predicted_variable)
    optimal_data <- optimal.thresholds(data, opt.methods = 1:9)
    list_data <- list()
    for (row_index in 1:nrow(optimal_data)) {
        row_value <- optimal_data[row_index, ]

        threshold_name <- as.character(row_value[["Method"]])
        threshold_value <- as.double(row_value[["Model 1"]])
        list_data[[threshold_name]] <- threshold_value
    }
    return(list_data)
}

#' Find optimal threshold
#' @param observed_variable Observed variable can be vector or rasterLyaer object
#' @param predicted_variable Predicted variable can be vector or rasterLyaer object
#' @return a directory represent optimal threshold
#' @details optimal threshold list: \cr
#'          'Default': threshold=0.5 \cr
#'          'Sens=Spec': sensitivity= specificity \cr
#'          'MaxSens+Spec': maximizes(sensitivity+specificity) \cr
#'          'MaxKappa': maximizes Kappa \cr
#'          'MaxPCC': maximizes PCC (precent correctly classified) \cr
#'          'PredPrev=Obs': predicted prevalence=observed prevalence \cr
#'          'ObsPrev': threshold=observed prevalence \cr
#'          'MeanProb': mean predicted probability \cr
#'          'MinROCdist': minizes distance between ROC plot and (0, 1) \cr
#'
#' @note All of those optimal threshold are provide by `PresenceAbsence` package. This function just reformat it output
#' @export
optimalThreshold <- function(observed_variable, predicted_variable) {
    UseMethod("optimalThreshold", observed_variable)
}

#' @export
optimalThreshold.RasterLayer <- function(observed_variable, predicted_variable) {
    predicted_variable <- rasterToPoints(predicted_variable)[, 3]
    observed_variable <- rasterToPoints(observed_variable)[, 3]
    optimalThreshold.numeric(predicted_variable, observed_variable)
}