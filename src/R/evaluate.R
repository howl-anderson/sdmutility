#!/usr/bin/env Rscript

#' @export
evaluatePrecision.numeric <- function(observed_value, predict_value, threshold) {
    prediction_object <- prediction(predict_value, observed_value)
    measure_method_list <- c('acc',
                             'err',
                             'fpr',
                             'fall',
                             'tpr',
                             'rec',
                             'sens',
                             'fnr',
                             'miss',
                             'tnr',
                             'spec',
                             'npv',
                             'pcmiss',
                             'rpp',
                             'rnp',
                             'rch',
                             'sar')

    measure_list <- list()
    for (measure_method in measure_method_list) {
        performance_object <- performance(prediction_object, measure_method)
        temp_value <- unlist(performance_object@x.values) >= threshold
        threshold_index <- which(temp_value)
        measure_value <- unlist(performance_object@y.values)[threshold_index[length(threshold_index)]]
        measure_list[[measure_method]] <- measure_value
    }


    # auc, rmse
    threhold_independent_measure_method_list <- c('auc',
                                                  'rmse')
    for (measure_method in threhold_independent_measure_method_list) {
        performance_object <- performance(prediction_object, measure_method)
        measure_value <- unlist(performance_object@y.values)
        measure_list[[measure_method]] <- measure_value
    }

    # kappa
    mat <- confusion_matrix(observed_value, predict_value, threshold=threshold)
    kappa <- SDMTools::Kappa(mat)
    measure_list[["kappa"]] <- kappa

    # tss
    measure_list[["tss"]] <- measure_list[["sens"]] + measure_list[["spec"]] - 1

    return(measure_list)
}

#' evaluatePrecision
#'
#' evaluate the precision of prediction
#'
#' @param observed_value observed value vector or rasterLyaer, notice value of vector or rasterLayer must be 0 or 1.
#' @param predict_value predicted value vector or rasterLyaer, notice value of vector or rasterLayer must in range (0 ~ 1)
#' @param threshold threhold or cutoff translate predicted continue value into binary value (0 or 1),
#'        normally the threshold value should in the range of (0 ~ 1), out of this range is also acceptable.
#' @return a list of many citens, see details
#' @details Current return about 23 citens. them are :
#'          'acc', 'err', 'fpr', 'fall', 'tpr', 'rec', 'sens', 'fnr', 'miss',
#'          'tnr', 'spec', 'npv', 'pcmiss', 'rpp', 'rnp', 'rch', 'sar', 'auc',
#'          'rmse', 'kappa', 'tss'
#'
#'          means about of those citens: \cr
#'          'acc': accuracy \cr
#'          'err': error rate \cr
#'          'fpr': false positive rate \cr
#'          'fall': fallout. same as fpr \cr
#'          'tpr': true positive rate \cr
#'          'rec': recall. same as tpr \cr
#'          'sens': sensitivity. same as tpr \cr
#'          'fnr': false negative rate \cr
#'          'miss': miss. same as fnr \cr
#'          'tnr': ture negative rate \cr
#'          'spec': specificity. same as tnr \cr
#'          'npv": negative predictive value \cr
#'          'pcmiss': prediction conditioned miss \cr
#'          'rpp': rate of positive predictions \cr
#'          'rnp': rate of positive predictions \cr
#'          'rch': ROC convex hull \cr
#'          'sar': score combinning performance measures of different characteristics \cr
#'          'auc': area under operator recevies curve \cr
#'          'kappa': Kappa statistic \cr
#'          'tss': true skill statistic or Hanssen-Kuiper score  \cr
#' @note Most power of this function are coming from package 'ROCR", we enchance a little
#' @export
evaluatePrecision <- function(observed_value, predict_value, threshold) {
    UseMethod("evaluatePrecision", observed_value)
}

#' @export
evaluatePrecision.RasterLayer <- function(observed_value, predict_value,  threshold) {
    observed_value <- rasterToPoints(observed_value)[, 3]
    predict_value <- rasterToPoints(predict_value)[, 3]
    evaluatePrecision.numeric(observed_value, predict_value, threshold)
}