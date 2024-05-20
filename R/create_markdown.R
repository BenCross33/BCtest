#' Generate Rmarkdown file
#' @param input_path A filepath of an excel table to import.
#' @param output_path A filepath of an excel table to export
#' @returns Rmarkdown file.
create_markdown <- function(input_path, output_path){

  df <- import_data(input_path)


  df[2, 2:ncol(df)] <- 50

  write_xlsx(df, output_path)
}
