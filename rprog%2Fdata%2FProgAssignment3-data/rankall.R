## Return a data frame with the hospital names and the
## (abbreviated) state name
# Call example:  head(rankall("heart attack", 20), 10)

# The num argument can take values “best”, “worst”, or an integer indicating 
# the ranking (smaller numbers are better). If the number given by num is 
# larger than the number of hospitals in that state, then the function should return NA.

rankall <- function(outcome, num = "best") {
  
  # Read outcome data
  data_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  # Check that outcome and num are valid
  # if (!is.element(state, data_outcome[['State']])) {
  #   stop("invalid state")
  # }
  outcomes_names <- c('heart attack', 'heart failure', 'pneumonia')
  if (!is.element(outcome, outcomes_names)){
    stop('invalid outcome')
  }
  
  result_df <- data.frame(Hospital = character(),
                          State = character(),
                          stringsAsFactors = FALSE)
  
  if (is.element(num, c('best', 'worst')) | is.numeric(num)) {
    
    hospital_index <- 2
    state_index <- 7
    
    # Outcomes
    # 11: Heart Attack
    # 17: Heart Failure
    # 23: Pneumonia
    outcomes <- c(11, 17, 23)
    names(outcomes) <- outcomes_names
    
    states <- unique(data_outcome[[state_index]])
    states <- sort(states)
    death_rate <- data_outcome[, c(hospital_index, state_index, outcomes[[outcome]])]
    colnames(death_rate)[1] <- 'Hospital'
    colnames(death_rate)[2] <- 'State'
    colnames(death_rate)[3] <- outcome
    
    for (state in states) {
      death_rate_state <- death_rate[death_rate[['State']] == state, ]
      death_rate_state[[3]] <- as.numeric(death_rate_state[[3]])
      death_rate_state <- death_rate_state[!is.na(death_rate_state[[3]]), ]
      death_rate_state <- death_rate_state[order(death_rate_state[, 3], death_rate_state[, 1]), ]
      
      if (num == 'best') {
        result <- death_rate_state[1, 1]
      } else if (num == 'worst') {
        result <- lapply(death_rate_state, tail, 1)
        result <- result[[1]]
      } else if (is.numeric(num) & num <= nrow(death_rate_state)) {
        result <- death_rate_state[num, 1]
      } else {
        result <- NA
      }
      element <- data.frame(Hospital = result, State = state, stringsAsFactors = FALSE)
      result_df <- rbind(result_df, element)
    }
  } else {
    stop('NA')
  }
  return(result_df)
}