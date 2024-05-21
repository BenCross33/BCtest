#' Generate Rmarkdown file
#' @param input_path A filepath of an excel table to import.
#' @param output_path A filepath of an excel table to export
#' @returns Rmarkdown file.
create_markdown <- function(input_path, output_path){

  df <- import_data(input_path)


  df[2, 2:ncol(df)] <- 50

  write_xlsx(df, output_path)

  march_c_value <- as.numeric(df[df$Variables == "C", "March"])
  april_c_value <- as.numeric(df[df$Variables == "C", "April"])


  params <- list(
    parameter1 = march_c_value,
    parameter2 = april_c_value
  )

  rmdFilename <- system.file("rmd", "testing.rmd", package = "BCtest")

  word_filename <- gsub(".Rmd$", ".doc", rmdFilename)

  rmarkdown::render(input =rmdFilename, output_file = word_filename, params = params, envir =  new.env())

  browseURL(word_filename)


}
