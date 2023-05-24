setwd("C:/Users/Adrien/OneDrive/Bureau/Work/ISEN/Big_Data/Projet A3-20230522/ProjetCIR3_BIGDATA")  
data <- read.csv(file = "csv_cleaned.csv", header = TRUE,  sep = ";")

# Créer un tableau croisé entre Variable1 et Variable2
tableau_croise <- table(data$Num_acc, data$id_code_insee)

# Effectuer le test d'indépendance du chi2 sur le tableau croisé
resultat_chi2 <- chisq.test(tableau_croise,)
