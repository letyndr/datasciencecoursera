# Return hospital name in that state with the given rank
# Call example: rankhospital("MD", "heart failure", 5)

# The num argument can take values “best”, “worst”, or an integer indicating 
# the ranking (smaller numbers are better). If the number given by num is 
# larger than the number of hospitals in that state, then the function should return NA.

rankhospital <- function(state, outcome, num = "best") {
  
  # Read outcome data
  data_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  # Check that state, outcome and num are valid
  if (!is.element(state, data_outcome[['State']])) {
    stop("invalid state")
  }
  outcomes_names <- c('heart attack', 'heart failure', 'pneumonia')
  if (!is.element(outcome, outcomes_names)){
    stop('invalid outcome')
  }
  
  if (is.element(num, c('best', 'worst')) | is.numeric(num)) {
    
    hospital_index <- 2
    state_index <- 7
    
    # Outcomes
    # 11: Heart Attack
    # 17: Heart Failure
    # 23: Pneumonia
    outcomes <- c(11, 17, 23)
    names(outcomes) <- outcomes_names
    death_rate <- data_outcome[data_outcome[[state_index]] == state, c(hospital_index, state_index, outcomes[[outcome]])]
    if (!is.element(num, c('best', 'worst')) & num > nrow(death_rate)) {
      'NA'
    }
    
    death_rate[[3]] <- as.numeric(death_rate[[3]])
    death_rate <- death_rate[!is.na(death_rate[[3]]), ]
    death_rate <- death_rate[order(death_rate[, 3], death_rate[, 1]), ]
    if (num == 'best') {
      result <- death_rate[1, 1]
    } else if (num == 'worst') {
      result <- lapply(death_rate, tail, 1)
      result <- result[[1]]
    } else {
      result <- death_rate[num, 1]
    }
    return(result)
  } else {
    stop('NA')
  }
}