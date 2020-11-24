

create_image <- function (branch, month, year) {
  
  
  month <- lubridate::month(as.numeric(month), label=T)
  
  # Read base image
  base_img_loc <- here::here("assets/cover.png")
  
  base_image <- magick::image_read(base_img_loc)
  
  # Annotate base image
  text <- glue::glue("For {branch}, ND Branch
                      {month}, {year}")
  
  final <- magick::image_annotate(base_image, text, size = 60, color = "white",
                                  degrees = 0,  location = "+150+330")

  return(final)
  
  
  
}