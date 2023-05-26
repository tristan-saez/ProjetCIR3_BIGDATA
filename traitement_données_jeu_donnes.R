

regions <- read.csv("commune_2009.csv", sep=",", fileEncoding="UTF-8")

cleaned <-read.csv("csv_cleaned.csv", sep=",", fileEncoding = "latin1")

population <-read.csv("Regions.csv", sep=",", fileEncoding="UTF-8")

colnames(population) <- c("COGREG", "REGION", "POPULATION_MUNICIPALE", "PTOT")

population_per_region <- population[c("COGREG", "PTOT")]

region_code_insee <- regions[c("Region","Code_Region","Code_INSEE","Code_Departement","Departement")]
cleaned_with_region <- merge(cleaned, region_code_insee, by.x ="id_code_insee", by.y="Code_INSEE", all.x=TRUE)

cleaned_with_region$Code_Region <- trimws(cleaned_with_region$Code_Region)
population_per_region$COGREG <- trimws(population_per_region$COGREG)

cleaned_with_region_population <- merge(cleaned_with_region, population_per_region, by.x = "Code_Region", by.y = "COGREG", all.x = TRUE)

doublons <- duplicated(cleaned_with_region_population)

cleaned_with_region_population <- subset(cleaned_with_region_population, !doublons)
class(cleaned_with_region_population$PTOT)
#View(cleaned_with_region_population)

cleaned_with_region_population$PTOT <- gsub(" ", "", cleaned_with_region_population$PTOT)
cleaned_with_region_population$PTOT <- as.numeric(cleaned_with_region_population$PTOT)
class(cleaned_with_region_population$PTOT)

write.csv(cleaned_with_region_population, file="cleaned_with_region_population.csv", fileEncoding="UTF-8")


#On agrége sur les accidents en fonction des régions ("code_region" et "nom_region") et de la gravité des accidents ("descr_grav"). 
#length compte le nombree d'occurences
accidents_par_region_gravite <- aggregate(Num_Acc ~ Code_Region + Region + descr_grav, cleaned_with_region_population, length)

#calculer la somme de la population totale pour chaque combinaison de valeurs des variables "Region" et "CODREG". 
#Ainsi, le résultat "habitants_par_region" contiendra les combinaisons de régions et la somme de la population totale correspondante.

habitants_par_region <- aggregate(PTOT ~ Code_Region + Region, cleaned_with_region_population, sum)

#fusionne acciden_par_region et habitants_par_region en fonctione de "code_region" et "nom_region"
accidents_population <- merge(accidents_par_region_gravite, habitants_par_region, by = c("Code_Region", "Region"))

#calcule le taux d'accidents pour 100 000 habitants pour chaque région 
#en effectuant une division entre le nombre d'accidents et la population totale, puis en multipliant le résultat par 100 000.
accidents_population$accidents_100k <- (lenght(accidents_population$Num_Acc) / accidents_population$PTOT) * 100000

#sauvegarde des données qui nous intéressent
jeu_donnees <- accidents_population[c("Code_Region", "Region", "descr_grav", "accidents_100k")]

write.csv(jeu_donnees, file="Jeu_de_donnees.csv", fileEncoding="UTF-8")
# Afficher le jeu de données final
print(jeu_donnees)
