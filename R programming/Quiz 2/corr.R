corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the 
  ## number of completely observed observations (on all 
  ## variables) required to compute correlations between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  df_complete = complete(directory)
  ids = df_complete[df_complete$nobs > threshold, ]$id
  cor_result = numeric()
  for (id in ids) {
    # aux_path = id
    if (id < 10)
      id <- paste("0", id, sep = "")
    if(id < 100)
      id <- paste("0", id, sep = "")
    file_name <- paste(directory, "/", id, ".csv", sep = "")
    my_data <- read.csv(file_name)
    my_data = my_data[complete.cases(my_data), ]
    cor_result = c(cor_result, cor(my_data$sulfate, my_data$nitrate))
  }
  return(cor_result)
  
}