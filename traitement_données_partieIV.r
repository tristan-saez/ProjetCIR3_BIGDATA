
#Ouverture des fichiers
regions <- read.csv("communes-departement-region.csv",header=TRUE, sep=",", fileEncoding="UTF-8")

cleaned <-read.csv("csv_cleaned.csv", sep=",")

population <-read.csv("Regions.csv", sep=";", fileEncoding="UTF-8")

#View(regions)
population_per_region <- population[c("CODREG","PTOT")]

region_code_insee <- regions[c("nom_region","code_region","code_commune_INSEE","code_departement","nom_departement")]


cleaned_with_region <- merge(cleaned, region_code_insee, by.x ="id_code_insee", by.y="code_commune_INSEE", all.x=TRUE)

cleaned_with_region_population <-merge(cleaned_with_region, population_per_region, by.x="code_region", by.y="CODREG", all.x=TRUE)

doublons <- duplicated(cleaned_with_region_population)

cleaned_with_region_population <- subset(cleaned_with_region_population, !doublons)

#View(cleaned_with_region_population)

View(cleaned_with_region_population)


#On agrége sur les accidents en fonction des régions ("code_region" et "nom_region") et de la gravité des accidents ("descr_grav"). 
#length compte le nombree d'occurences
accidents_par_region_gravite <- aggregate(Num_Acc ~ code_region + nom_region + descr_grav, cleaned_with_region_population, length)

#agrège les données sur la population par région.
# calcule la somme de la population totale ("PTOT") pour chaque combinaison de valeurs des variables "code_region" et "nom_region"
habitants_par_region <- aggregate(PTOT ~ code_region + nom_region, cleaned_with_region_population, sum)

#fusionne acciden_par_region et habitants_par_region en fonctione de "code_region" et "nom_region"
accidents_population <- merge(accidents_par_region_gravite, habitants_par_region, by = c("code_region", "nom_region"))

#calcule le taux d'accidents pour 100 000 habitants pour chaque région 
#en effectuant une division entre le nombre d'accidents et la population totale, puis en multipliant le résultat par 100 000.
accidents_population$accidents_100k <- (accidents_population$Num_Acc / accidents_population$PTOT) * 100000

#sauvegarde des données qui nous intéressent
jeu_donnees <- accidents_population[c("code_region", "nom_region", "descr_grav", "accidents_100k")]

# Afficher le jeu de données final
print(jeu_donnees)
