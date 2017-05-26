complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for whichwe will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used.
  
  ## Return the mean of the pollutant accross all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!!
  
  result_df <- data.frame(id = integer(0),
                        nobs = integer(0))
  for (monitor in id) {
    aux_path <- monitor
    if (aux_path < 10)
      aux_path <- paste("0", aux_path, sep = "")
    if(aux_path < 100)
      aux_path <- paste("0", aux_path, sep = "")
    file_name <- paste(directory, "/", aux_path, ".csv", sep = "")
    my_data <- read.csv(file_name)
    nobs <- sum(complete.cases(my_data))
    result_df <- rbind(result_df, data.frame("id" = monitor, "nobs" = nobs))
  }
  return(result_df)
}
