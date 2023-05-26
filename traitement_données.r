

data <- read.csv("stat_acc_V4.csv", sep=",")

#I-Type de données
type <- class(data)
print("Type de données:")
print(type) 

#Nombre de données
print("Nombre de données avant le tri")
print(nrow(data))

#Trouver si'il y a des valeurs nulles par colonnes
col_names <- colnames(data)
cols_with_null <- vector()
cols_without_null <- vector()

for (col in col_names) {
  if (sum(is.na(data[[col]])) > 0) {
    cols_with_null <- c(cols_with_null, col)
  } else {
    cols_without_null <- c(cols_without_null, col)
  }
}

# Affichage des colonnes contenant des valeurs nulles
print("Colonnes contenant des valeurs nulles :")
print(cols_with_null)

# Affichage des colonnes ne contenant pas de valeurs nulles
print("Colonnes ne contenant pas de valeurs nulles :")
print(cols_without_null)

#Trouver l'indice avec les valeurs nulles

# Suppression des lignes qui contiennet des valeurs nulles 
data_filtered <- data[complete.cases(data[, cols_with_null]), ]

# Affichage de la matrice de données filtrée
print("Nombre restantes après avoir retirées les nulles")
print(nrow(data_filtered))


# Compter le nombre de ligne qui contient latitude qui a une valeu de 2009
count_2009_latitude <- sum(data_filtered$latitude == 2009, na.rm = TRUE)


#print(count_2009_latitude)
#print("Nombre de données qui contiennent 2009 en latitude")

# Filtrer et affecter uniquement les lignes qui n'ont pas 2009 en latitude
data_filtered <- data_filtered[data_filtered$latitude != 2009, ]


#print(data_filtered)

count_filtered <- nrow(data_filtered[data_filtered$latitude != 2009, ])
#print("Nombre de données restantes")
#print(count_filtered)

#data_filtered["age"] <- data_filtered["age"] - 14
#data_filtered <- data_filtered[data_filtered$age > 15,]
# Extraire en fichier csv
beta_test <- data_filtered

View(beta_test)
# Sauvegarde de la matrice de données filtrée au format CSV
write.csv(beta_test, file = "csv_cleaned.csv", row.names = FALSE)

