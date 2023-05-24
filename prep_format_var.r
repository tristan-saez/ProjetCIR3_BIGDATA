#library(rstatix)

data <- read.csv(file = "stat_acc_V3.csv", header = TRUE,  sep = ";")

# Formatage des colones
data$date <- as.POSIXct(factor(data$date))
data$Num_Acc <- as.integer(factor(data$Num_Acc))
data$id_usa <- as.integer(factor(data$id_usa))
data$id_code_insee <- as.integer(factor(data$id_code_insee))
data$num_veh <- as.integer(factor(data$num_veh))
data$descr_grav <- as.integer(factor(data$descr_grav))

write.csv(data, "csv_cleaned.csv")