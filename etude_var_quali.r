# setwd("C:/Users/Adrien/OneDrive/Bureau/Work/ISEN/Big_Data/Projet A3-20230522/ProjetCIR3_BIGDATA")

# Ouvre le nouveau CSV
data <- read.csv(file = "csv_cleaned.csv", header = TRUE,  sep = ",")

# --------------------------1---------------------------
# Tableau croisé entre Catégories de véhicule et Gravités de l'accident
tableau_croise_grav <- table(data$descr_cat_veh, data$descr_grav)
# png("tableau_croise_grav.png", width = 800, height = 600)
# Test d'indépendance du chi2 sur le tableau croisé
resultat_chi2_grav <- chisq.test(tableau_croise_grav, simulate.p.value = TRUE)
residuts_chi2_grav <- resultat_chi2_grav$residuals - min(resultat_chi2_grav$residuals) + 1
# print(resultat_chi2_grav)

mosaicplot(tableau_croise_grav, color = residuts_chi2_grav, main = "Tableau croisé des catégories de véhicule et des gravités d'accident", 
           xlab = "Catégories de véhicule", ylab = "Gravités de l'accident")
# dev.off()

# --------------------------2---------------------------
# Tableau croisé entre la luminosité et gravité de l'accident
tableau_croise_lum <- table(data$descr_lum, data$descr_grav)
# png("tableau_croise_lum.png", width = 800, height = 600)
# Test d'indépendance du chi2 sur le tableau croisé
resultat_chi2_lum <- chisq.test(tableau_croise_lum, simulate.p.value = TRUE)
residuts_chi2_lum <- resultat_chi2_lum$residuals - min(resultat_chi2_lum$residuals) + 1
# print(resultat_chi2_lum)

mosaicplot(tableau_croise_lum, color = residuts_chi2_lum, main = "Tableau croisé de la luminosité et de la gravité de l'accident", 
           xlab = "luminosité", ylab = "Gravités de l'accident")
# dev.off()

# --------------------------3---------------------------
# Tableau croisé entre la description athmo et gravité de l'accident
tableau_croise_athmo <- table(data$descr_athmo, data$descr_grav)

# Test d'indépendance du chi2 sur le tableau croisé
resultat_chi2_athmo <- chisq.test(tableau_croise_athmo, simulate.p.value = TRUE)
residuts_chi2_athmo <- resultat_chi2_athmo$residuals - min(resultat_chi2_athmo$residuals) + 1
# print(resultat_chi2_athmo)

mosaicplot(tableau_croise_athmo, color = residuts_chi2_athmo, main = "Tableau croisé de la condi athmosphèrique et de la gravité de l'accident", 
           xlab = "condi athmosphèrique", ylab = "Gravités de l'accident")


# --------------------------4---------------------------
# Tableau croisé entre le type de collision et gravité de l'accident
tableau_croise_col <- table(data$descr_type_col, data$descr_grav)
# png("tableau_croise_col.png", width = 800, height = 600)
# Test d'indépendance du chi2 sur le tableau croisé
resultat_chi2_col <- chisq.test(tableau_croise_col, simulate.p.value = TRUE)
residuts_chi2_col <- resultat_chi2_col$residuals - min(resultat_chi2_col$residuals) + 1
# print(resultat_chi2_col)

mosaicplot(tableau_croise_col, color = residuts_chi2_col, main = "Tableau croisé du type de collision et de la gravité de l'accident", 
           xlab = "type de collision", ylab = "Gravités de l'accident")
# dev.off()

# --------------------------5---------------------------
# Tableau croisé entre l'age et gravité de l'accident
tableau_croise_age <- table(data$age, data$descr_grav)
# png("tableau_croise_age.png", width = 800, height = 600)
# Test du chi2 sur le tableau croisé
resultat_chi2_age <- chisq.test(tableau_croise_age, simulate.p.value = TRUE)
residuts_chi2_age <- resultat_chi2_age$residuals - min(resultat_chi2_age$residuals) + 1
# print(resultat_chi2_age)

mosaicplot(tableau_croise_age, color = residuts_chi2_age, main = "Tableau croisé de l'age et de la gravité de l'accident", 
           xlab = "age", ylab = "Gravités de l'accident")
# dev.off()

# --------------------------6---------------------------
# Tableau croisé entre l'agglo et gravité de l'accident
tableau_croise_agglo <- table(data$descr_agglo, data$descr_grav)
# png("tableau_croise_agglo.png", width = 800, height = 600)
# Test du chi2 sur le tableau croisé
resultat_chi2_agglo <- chisq.test(tableau_croise_agglo, simulate.p.value = TRUE)
residuts_chi2_agglo <- resultat_chi2_agglo$residuals - min(resultat_chi2_agglo$residuals) + 1
print(resultat_chi2_agglo)

mosaicplot(tableau_croise_agglo, color = residuts_chi2_agglo, main = "Tableau croisé de l'agglo et de la gravité de l'accident", 
           xlab = "agglo", ylab = "Gravités de l'accident")
# dev.off()
