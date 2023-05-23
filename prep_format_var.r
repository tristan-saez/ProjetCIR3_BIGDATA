library(ggplot2)
#library(rstatix)

data <- read.csv(file = "stat_acc_V3.csv", header = TRUE,  sep = ";")

data$date <- as.POSIXct(factor(data$date))
data$Num_Acc <- as.integer(factor(data$Num_Acc))
data$id_usa <- as.integer(factor(data$id_usa))
data$id_code_insee <- as.integer(factor(data$id_code_insee))

write.csv(data, "newcsv.csv") 