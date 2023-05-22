data <- read.csv("csv_cleaned.csv", sep = ",", fileEncoding = "latin1")
View(data, "données")

#Remplacement des numéros de véhicule par une valeur en chiffre
num_veh <- unique(data$num_veh)

i <- 0
num_veh_dict <- c()

for (val in num_veh) {
    num_veh_dict[val] <- i
    i <- i + 1
}
View(num_veh_dict, "Valeurs des vehicules")


#Remplacement de la gravité de l'accident par une valeur en chiffre
descr_grav <- unique(data$descr_grav)

i <- 0
descr_grav_dict <- c()

for (val in descr_grav) {
    descr_grav_dict[val] <- i
    i <- i + 1
}
View(descr_grav_dict, "Valeurs de la gravité des accidents")


#Remplacement dans la base
i <- 0
for (val in data$num_veh) {
    data$num_veh[i] <- num_veh_dict[val]
    i <- i + 1
}

i <- 0
for (val in data$descr_grav) {
    data$descr_grav[i] <- descr_grav_dict[val]
    i <- i + 1
}
View(data, "données modifiées")

write.csv(data, "csv_cleaned.csv")