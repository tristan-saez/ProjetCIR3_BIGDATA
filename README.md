# ProjetCIR3_BIGDATA

### Description -------------

Projet réalisé dans le cadre du Projet BIG DATA de l'ISEN Yncrea Ouest.
Tristan Saëz - Adrien LeBoucher - Vincent Le Brenn

### -------------------------

### Ordre d'excution :

1. traitement_données.r
2. prep_format_var.r
3. traitement_données_jeu_donnes.r

Ensuite, les autres peuvent être executé en fonction de ce que vous voulez afficher



### packages/libraries utilisés par les programmes R :

```bash
install.packages("ggplot")
install.packaghes("leaflet")
install.packages("mapvbiew")
install.packages("rgdal")
```

### Description des fichier :

1. stat_acc_V3.csv : fichier initial séparé par des ";"
2. stat_acc_V4.csv : fichier initial séparé par des ","
3. departements-regions.csv : fichier .csv représentant chaque département lié à leur région
4. commune_2009.csv : liste des communes de france en 2009
5. Jeu_de_donnees.csv : nombre d'accident par région par type de gravité pour 100 000 habitants en %
6.  csv_cleaned.csv : fichier final, nettoyé des outliers

### Description des dossiers :

1. cartes : dossier contenant les cartes récupérées via les fichiers .r affiche_carte_{x}.r
2. Autre : dossier contenant la présentation, le diagramme de Gantt et le Rapport de 5 pages
3. graphiques : dossier contenant les graphiques obtenus via les fichier d'histogramme et de régression linéaire
