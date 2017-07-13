# Return hospital name in that state with lowest 30-day death
# Call example: best("TX", "heart attack")

best <- function(state, outcome) {
  
  # Read outcome data
  data_outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check that state and outcome are valid
  if (!is.element(state, data_outcome[['State']])) {
    stop("invalid state")
  }
  outcomes_names <- c('heart attack', 'heart failure', 'pneumonia')
  if (!is.element(outcome, outcomes_names)){
    stop('invalid outcome')
  }
  hospital_index <- 2
  state_index <- 7
  
  # Outcomes
  # 11: Heart Attack
  # 17: Heart Failure
  # 23: Pneumonia
  outcomes <- c(11, 17, 23)
  names(outcomes) <- outcomes_names
  death_rate <- data_outcome[data_outcome[[state_index]] == state, c(hospital_index, state_index, outcomes[[outcome]])]
  death_rate[[3]] <- as.numeric(death_rate[[3]])
  death_rate <- death_rate[!is.na(death_rate[[3]]), ]
  min_death_rate <- death_rate[which.min(death_rate[[3]]), 1]
  
  # Return value: rate
  min_death_rate[1]
}