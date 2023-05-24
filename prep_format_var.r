# setwd("C:/Users/Adrien/OneDrive/Bureau/Work/ISEN/Big_Data/Projet A3-20230522/ProjetCIR3_BIGDATA")

# Ouvre le nouveau CSV
data <- read.csv(file = "csv_cleaned.csv", sep = ",", fileEncoding = "UTF-8")

# Formatage des colones moda
data$date <- as.POSIXct(data$date)
data$num_veh <- as.numeric(data$num_veh)
data$descr_grav <- as.numeric(data$descr_grav)

# Ecrit dans le nouveau CSV
write.csv(data, "csv_cleaned.csv")