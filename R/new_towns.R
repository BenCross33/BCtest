model <- lm(`Town GVA/Cap` ~ `Nearest City GVA` + `City GVA/Cap` + `Time to City (Rail)`, data = ntowns_data)

summary(model)


# Number of hexes, local authorities, and regions
num_hexes <- 900
num_las <- 9
num_regions <- 3
hexes_per_la <- 100
las_per_region <- num_las / num_regions

# Create Hexed column
Hexes <- paste0("H", 1:num_hexes)

# Create Local Authorities column
Local_Authorities <- rep(paste0("LA", 1:num_las), each = hexes_per_la)

# Create Region column
Region <- rep(paste0("R", 1:num_regions), each = hexes_per_la * las_per_region)

# Generate normally distributed values and bound them between 0 and 100 where applicable
set.seed(123)  # Setting seed for reproducibility

generate_bounded_normal <- function(n, mean, sd, lower, upper) {
  values <- rnorm(n, mean, sd)
  values <- pmax(pmin(values, upper), lower)
  return(values)
}

Percent_Development <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Greenbelt_Percent <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Ancient_Woodland_Percent <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Irreplaceable_Habitats_Percent <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Special_Protection_Areas_Percent <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Built_Up_Area_Percent <- generate_bounded_normal(num_hexes, mean = 50, sd = 20, lower = 0, upper = 100)
Nearest_Motorway_Junction_km <- generate_bounded_normal(num_hexes, mean = 20, sd = 10, lower = 0, upper = 40)
Nearest_Train_Station_km <- generate_bounded_normal(num_hexes, mean = 15, sd = 7.5, lower = 0, upper = 30)
Nearest_Urban_Centre_km <- generate_bounded_normal(num_hexes, mean = 20, sd = 10, lower = 0, upper = 40)

# Generate binary columns
Water_Scarcity <- sample(0:1, num_hexes, replace = TRUE)
National_Grid <- sample(0:1, num_hexes, replace = TRUE)
Flood_Zone_3 <- sample(0:1, num_hexes, replace = TRUE)

# Combine into a dataframe
df <- data.frame(
  Hexes,
  Local_Authorities,
  Region,
  Percent_Development,
  Water_Scarcity,
  National_Grid,
  Greenbelt_Percent,
  Ancient_Woodland_Percent,
  Irreplaceable_Habitats_Percent,
  Special_Protection_Areas_Percent,
  Flood_Zone_3,
  Built_Up_Area_Percent,
  Nearest_Motorway_Junction_km,
  Nearest_Train_Station_km,
  Nearest_Urban_Centre_km
)

model <- lm(
  Percent_Development ~ Water_Scarcity + National_Grid + Greenbelt_Percent +
    Ancient_Woodland_Percent + Irreplaceable_Habitats_Percent +
    Special_Protection_Areas_Percent + Flood_Zone_3 + Built_Up_Area_Percent +
    Nearest_Motorway_Junction_km + Nearest_Train_Station_km +
    Nearest_Urban_Centre_km,
  data = df
)

# Summarize the model
summary(model)
