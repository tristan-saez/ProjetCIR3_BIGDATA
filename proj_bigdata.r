data <- read.csv(file = "stat_acc_V3.csv", header = TRUE,  sep = ";")


data$date <- as.POSIXct(factor(data$date))
data$id_usa <- as.integer(factor(data$id_usa))

write.csv(data, "newcsv.csv")

#rstatix