#' Import data
#'
#' @param input_path A filepath of an excel table to import.
#' @returns Rmarkdown file.
import_data <- function(input_path){

  # Read the Excel file and save it as df1
  df1 <- read_excel(input_path)

  # Return the data frame
  return(df1)

}
