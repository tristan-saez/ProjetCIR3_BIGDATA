data <- read.csv("csv_cleaned.csv", sep = ",", fileEncoding = "UTF-8")
View(data, "données")

#Remplacement des numéros de véhicule par une valeur en chiffre
#c(B02 = 1, A01 = 2, B01 = 3, A02 = 4, C01 = 5, T01 = 6, C02 = 7,
#C03 = 8, D04 = 9, E05 = 10, Z01 = 11, D01 = 12, E01 = 13, F06 = 14,
#G07 = 15, H08 = 16, H02 = 17, F02 = 18, G02 = 19, A27 = 20, B28 = 21,
#I09 = 22, K11 = 23, L12 = 24, M13 = 25, N14 = 26, Q17 = 27, S19 = 28,
#T20 = 29, U21 = 30, V22 = 31, W23 = 32, X24 = 33, Z26 = 34, O15 = 35,
#R18 = 36, Y25 = 37, J10 = 38, P16 = 39, A03 = 40, G01 = 41, J03 = 42,
#F01 = 43, L03 = 44, H01 = 45, I01 = 46, K03 = 47, D03 = 48, D02 = 49,
#E02 = 50, E04 = 51, D05 = 52, X01 = 53, F04 = 54, G04 = 55, N01 = 56)
num_veh <- unique(data$num_veh)

i <- 1
num_veh_dict <- c()

for (val in num_veh) {
    num_veh_dict[val] <- i
    i <- i + 1
}
View(num_veh_dict, "Valeurs des vehicules")


#Remplacement de la gravité de l'accident par une valeur en chiffre
#c(Indemne = 1, Tué = 2, "Blessé hospitalisé" = 3, "Blessé léger" = 4)
descr_grav <- unique(data$descr_grav)

i <- 1
descr_grav_dict <- c()

for (val in descr_grav) {
    descr_grav_dict[val] <- i
    i <- i + 1
}
#View(descr_grav_dict, "Valeurs de la gravité des accidents")


#Remplacement dans la base
i <- 1
for (val in data$num_veh) {
    data$num_veh[i] <- num_veh_dict[val]
    i <- i + 1
}

i <- 1
for (val in data$descr_grav) {
    data$descr_grav[i] <- descr_grav_dict[val]
    i <- i + 1
}
View(data, "données modifiées")

write.csv(data, "csv_cleaned.csv")