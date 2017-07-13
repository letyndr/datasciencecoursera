pollutantmean <- function(directory, pollutant, id = 1:332) {
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

  mean_aux <- c()
  for (monitor in id) {
    if (monitor < 10)
      monitor <- paste("0", monitor, sep = "")
    if(monitor < 100)
      monitor <- paste("0", monitor, sep = "")
    file_name <- paste(directory, "/", monitor, ".csv", sep = "")
    my_data <- read.csv(file_name)
    mean_aux <- c(mean_aux, my_data[[pollutant]])
  }
  result <- mean(mean_aux, na.rm = TRUE)
  round(result, 3)
}
