test_that("defalut", {
    observed.variable <- c(1,1,0,1,1,0,1,0,0)
    predicted.variable <- c(0.1,0.2,0.9,0.7,0.3,0.2,0.4,0.5,0.6)
    
    result <- optimalThreshold(observed.variable, predicted.variable)
    standard.result <- list(SensESpec=0.5, MaxSensPSpec=0.1, MaxKappa=0.1, MaxTSS=0.1)
    
    expect_equal(result, standard.result)
})