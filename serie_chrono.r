data <- read.csv("csv_cleaned.csv", sep = ",", fileEncoding = "UTF-8")
View(data, "données")

tot_mois <- c(
    "01" = 0,
    "02" = 0,
    "03" = 0,
    "04" = 0,
    "05" = 0,
    "06" = 0,
    "07" = 0,
    "08" = 0,
    "09" = 0,
    "10" = 0,
    "11" = 0,
    "12" = 0
)

tot_semaine <- c()
for (value in c(1:53)) {
    tot_semaine[toString(value)] <- 0
}




for (date_n_hour in data$date) {
    date <- unlist(strsplit(date_n_hour, " "))
    month <- unlist(strsplit(date[1], "-"))
    tot_semaine[format(as.Date(date[1]), "%-V")] = tot_semaine[format(as.Date(date[1]), "%-V")] + 1
    tot_mois[month[2]] <- tot_mois[month[2]] + 1
}

data_mois <- data.frame(names(tot_mois), unname(tot_mois))
colnames(data_mois) <- c("Mois", "nb_acc")

data_semaine <- data.frame(names(tot_semaine), unname(tot_semaine))
colnames(data_semaine) <- c("Semaine", "nb_acc")

print(sum(data_semaine["nb_acc"]))
