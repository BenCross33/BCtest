#' Generate Rmarkdown file
#' @param input_path A filepath of an excel table to import.
#' @param output_path A filepath of an excel table to export
#' @returns Rmarkdown file.
#' @export
create_markdown <- function(input_path, output_path){
#import data
  df <- import_data(input_path)

#make data changes
  df[2, 2:ncol(df)] <- 50
#export data
  writexl::write_xlsx(df, output_path)


#get needed values
  march_c_value <- as.numeric(df[df$Variables == "C", "March"])
  april_c_value <- as.numeric(df[df$Variables == "C", "April"])

#list parameters
  params <- list(
    parameter1 = march_c_value,
    parameter2 = april_c_value
  )

#find rmd file and craete rmd export location
  rmdFilename <- system.file("rmd", "testing.rmd", package = "BCtest")
  word_filename <- gsub(".Rmd$", ".doc", rmdFilename)

#generate and open word created from markdown
  rmarkdown::render(input =rmdFilename, output_file = word_filename, params = params, envir =  new.env(), overwrite = TRUE)
  browseURL(word_filename)


}
