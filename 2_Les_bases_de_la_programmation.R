
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 2 - Les bases de la programmation R
# # # # # # # # # # # # # # # # # # # # # # # # # # 

# Vérification du répertoire de travail
getwd()

# Si mauvais répertoire, charger à l'aide de la fonction 
# setwd()

# Trouver de l'aide pour l'utilisation d'une fonction 
# ?nom_de_la_fonction 
?library
?mean

# Affectation simple
mon_resultat <- 1 + 3 
mon_resultat


### 
### Les Objets R 
### 

# Création d'un vecteur
v <- c(1,2,3) # v est le nom de mon vecteur 

# Création d'une matrice 2 lignes * 3 colonnes
m <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3) # Matrice 2*3
m <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3, 
            dimnames = list(c("ligne1", "ligne2"), 
                            c("colonne1", "colonne2", "colonne3")))
m[1,2] # renvoie l'élément situé sur la 1ere ligne de la 2 colonne 

# Création et remplissage de la matrice en ligne
m2 <- matrix(1:12, nrow = 3, byrow = TRUE)

# Création matrice carrée
m3 <- matrix(1:16, nrow = 4, byrow = TRUE)

# Création d'une liste 
L <- list(1, 2, 3, "hello", c(4, 5, 6)) 
L <- list(nombre = 1, mot = "hello", vecteur = c(4, 5, 6)) 
L[1]  
L$mot

# Création d'un data frame
DF <- data.frame(x = c(1,2,3), 
                 y = c(4,5,6), 
                 z = c("a", "b", "c"))
DF[1, "x"]  # affiche 1 de la colonne x
DF$y        # affiche 4 5 6 
DF[DF$x == 2 & DF$y == 5, ]
DF[, -2] # supprime la 2e colonne

# Création d'une chaine de caractères 
Ma_chaine <- "Hello, world!"

# Combinaison de chaine de caractères
Mot1 <- "Hello"
Mot2 <- "world!"
Chaine1 <- paste(Mot1, Mot2, sep = ", ")
Chaine1
Chaine2 <- paste0(Mot1, ", ", Mot2)
Chaine2


# Conversion en minuscule
my_string <- "Hello, world!"
result <- tolower(my_string)
result

# Conversion en majuscule
my_string <- "Hello, world!"
result <- toupper(my_string)
result

# Extraire les 5 premières lettres de la chaine de caractères
chaine <- "Hello, world!"
sous_chaine <- substr(my_string, start = 1, stop = 5)
sous_chaine

# Séparation de la chaine en fonction selon un caractère séparateur « , »
chaine <- "Hello, world!"
sous_chaine <- strsplit(my_string, ",")
sous_chaine

# Recherche d’un mot dans la chaine
chaine <- "Hello, world!"
sous_chaine <- "world"
resultat <- grepl(sous_chaine, chaine)
resultat

# Recherche & remplace
chaine <- "Hello, world!"
ancienne_sous_chaine <- "world"
nouvelle_sous_chaine <- "universe"
resultat <- gsub(ancienne_sous_chaine, nouvelle_sous_chaine, chaine)
resultat

# Opérateurs logiques 
x <- 2
y <- 3

## et
x == 2 & y == 3  # TRUE
x == 2 & y == 2  # FALSE

# ou
x == 2 | y == 3  # TRUE
x == 1 | y == 2  # FALSE

# différent 
!(x == 2)  # FALSE
!(x == 1)  # TRUE


### 
### Exemples d’instructions en R
### 


# Calculatrice 
2 + 3
5 * 8
15/98 

## 1 – Les opérations avec des fonctions
exp(5)                          # exponentielle
log(20)				                  # logarithme
sin(pi/2) + cos(pi/2)           # trigonométrie
gamma(5)                        # gamma

## 2 – L’affectation
Mon_nombre_1 <- 10                # affecter 10 à la variable 'Mon_nombre_1'
Mon_nombre_1                      # voir le contenu
(Mon_nombre_1 <- 10)              # affecter et afficher
Mon_nombre_2 <- Mon_nombre_1 # affecter la valeur de 'Mon_nombre_1' à ' Mon_nombre_2'
Mon_nombre_1 <- 25       # changer la valeur de 'Mon_nombre_1'…
Mon_nombre_1
Mon_nombre_2             #…  ne change pas celle de 'Mon_nombre_2'

## 3 – Nomination des objets : les variables
foo <- 152                   # ok
foo.123 <- 10                # ok
foo_123 <- 78                # ok
Foo <- 96			               # ok
FoO <- 15                    # ok
#123foo <- 5                  # invalide ; commence par un chiffre
#.123foo <- 5                 # invalide ; point suivi d'un chiffre

## 4 – Les objets dans R
### 4.1 Les vecteurs
Mon_vecteur <- c(-7, 8, 90, 8123)
Mon_vecteur

# On peut donner des étiquettes aux éléments d'un vecteur.
x <- c(a = -7, b = 8, c = 90, d = 8123) # a, b, c, d sont les étiquettes du vecteur
names(x)                        # extraction des étiquettes
x[1]                            # extraction de l’élément à la 1ere position 
x["c"]                          # extraction de l’élément 3 selon l’étiquette
x[-2]                           # élimination d'un élément à la 2e position
y <- x[-3]     # copie du vecteur 'x' en éliminant le troisième élément 
y
names(x) <- NULL                # suppression des étiquettes
x

# Création d’un vecteur numérique si les valeurs se suivent 
z <- 1:10 
z
s <- seq(1, 5, 0.5) # Création d’une séquence allant de 1 à 5 par pas de 0,5
s

### 4.2 Les matrices
Ma_matrice <- matrix(1:12, nrow = 3, ncol = 4) 
Ma_matrice  
length(Ma_matrice)           # 'Ma_matrice' est un vecteur...
dim(Ma_matrice)              # ... avec un attribut 'dim'...
class(Ma_matrice)            # ... et classe implicite "matrix"
Ma_matrice[1, ]              # 1ère ligne de la matrice
Ma_matrice[, 2]              # 2e colonne de la matrice
Ma_matrice[1, 3]             # l'élément en position (1, 3)...
Ma_matrice[7]                # ... est le 7e élément du vecteur
nrow(Ma_matrice)             # nombre de lignes
ncol(Ma_matrice)             # nombre de colonnes

x <- matrix(1:12, nrow = 3, ncol = 4)      # 'x' est une matrice 3 x 4
y <- matrix(1:8, nrow = 2, ncol = 4)       # 'y' est une matrice 2 x 4
z <- matrix(1:6, nrow = 3, ncol = 2)      # 'z' est une matrice 3 x 2
v <- 1:4                                   # 'v' est un vecteur
##### Fusion de matrices et vecteurs
rbind(x,v)                      # ajout d'une ligne à 'x'
rbind(x, y)                     # fusion verticale de 'x' et 'y'
cbind(x, z)                     # concaténation de 'x' et 'z'
# rbind(x, z)                     # dimensions incompatibles
# cbind(x, y)                     # dimensions incompatibles

### 4.3 Les listes
Ma_liste <- list(joueur = c("V", "C", "C", "M", "A"),
                 score = c(10, 12, 11, 8, 15),
                 expert = c(FALSE, TRUE, FALSE, TRUE, TRUE),
                 niveau = 2)
length(Ma_liste)             # Nombre d'élèment dans la liste

y <- list(TRUE, 1:5)         # définition d’une liste de deux éléments
Ma_liste <- c(Ma_liste, y)   # fusion de 2 listes 
Ma_liste
Ma_liste[[1]]                # premier élément de la liste...
Ma_liste$joueur              # équivalent à a[[1]]
Ma_liste[1]                  # aussi le premier élément...
length(Ma_liste[1])          # ... d'un seul élément
Ma_liste[[2]][1]             # 1er élément du 2e élément
Ma_liste$score[1]            # équivalent à a[[c(2, 1)]]
Ma_liste[[5]] <- matrix(1, 2, 2)    # ajout d’une matrice
Ma_liste[[6]] <- list(20:25, TRUE)  # ajout d’une autre liste
Ma_liste[[7]] <- exp                # ajout d'une fonction!
Ma_liste                          
Ma_liste[[7]] <- NULL 	     # suppression du 7e élément
Ma_liste   

### 4.4 Les data frames
DF <- data.frame(Noms = c("Pierre", "Jean", "Jacques"),
                 Age = c(42, 34, 19),
                 Fumeur = c(TRUE, TRUE, FALSE))
dim(DF)                         # affiche les dimensions 
names(DF)                       # titres des colonnes
row.names(DF)                   # titres des lignes 
DF[1, ]                         # 1ère ligne
DF[, 1]                         # 1ère colonne
DF$Noms                         # idem, mais plus simple

### Cas particulier des données manquantes : NA
x <- c(1, 6, NA, 54674, NA, 875)
is.na(x)                        # renvoie si la donnée est manquante alors TRUE
x[!is.na(x)]                    # récupération des données NON manquantes
x[is.na(x)] <- 0                # remplace les données manquantes par des 0
x          

## 5 – Filtrer à l’aide des opérateurs logiques
x <- 2
y <- 3
x == 2 & y == 3  # TRUE
x == 2 & y == 2  # FALSE

# Indicage
x <- 1:20
x[1:10]                         # avec des entiers positifs
x[x < 10]                       # avec un opérateur logique

x <- c(a = -7, k = 8, c = 90, t = 8123)
x[c("a", "k", "t")]             # par étiquettes

x <- matrix(1:12, nrow = 3, ncol = 4)      
x[1, 2]                         # élément en position (1, 2)
x[1, -2]                        # 1ère ligne sans 2e colonne
x[c(1, 3), ]                    # 1ère et 3e ligne
x[-1, ]                         # affichage sans la 1ère ligne

DF <- data.frame(Noms = c("Pierre", "Jean", "Jacques"),
                 Age = c(42, 34, 19),
                 Fumeur = c(TRUE, TRUE, FALSE))
DF$Noms                         # affiche les éléments de la variable Noms
DF$Fumeur                       # affiche les éléments de la variable Fumeur


### 
### Importer des données externes
### 

#  !!!!! ATTENTION 
# l'execution ne fonctionnera pas pour cette partie 

# 1- données dans un fichier CSV
people <- read.csv(file = "Data/people-100.csv", header = TRUE)
people

# 2- données dans un fichier excel
library(readxl)
people <- read_excel(file = "Data/people-100.csv", header = TRUE, sheet = 1)
people

# 3- Données dans une table PostgreSQL

# Installation et chargement du package RPostgreSQL 
install.packages("RPostgreSQL")
library(RPostgreSQL)

# Connexion à la base de données PostgreSQL. Par exemple si :
# le nom de l’hôte = "localhost", 
# le port = 5432,
# le nom de la base : "mydatabase", 
# le nom d’utilisateur = "myuser"
# le mot de passe = "mypassword", alors la connexion ressemblera à :
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host = "localhost", port = 5432, dbname = "mydatabase", user = "myuser", password = "mypassword")

# Une fois la connexion établie, il suffit de stocker le résultat de la requête dans un objet R. 
# Par exemple, si vous souhaitez importer toutes les lignes de la table "mytable", alors :
query <- "SELECT * FROM mytable" # langage SQL
data <- dbGetQuery(con, query) # stockage du résultat dans l’objet "data"

# Une fois terminé vous pouvez éteindre la connexion entre R et PostgreSQL
dbDisconnect(con)

# 4- Données à partir d'une API web
# Installation et chargement du package httr 
install.packages("httr")
library(httr)

# Ensuite, utilisez la fonction GET pour envoyer une requête à l'API web et récupérer les données.
# Vous devrez fournir l'URL de l'API et éventuellement des informations d'authentification ou des paramètres de requête
# Par exemple, si l'URL de l'API est "https://api.example.com/data" et que vous voulez récupérer des données au format JSON :
reponse <- GET("https://api.example.com/data", accept("application/json"))

# Utilisez la fonction content pour stocker les données dans l’objet data
data <- content(reponse)
