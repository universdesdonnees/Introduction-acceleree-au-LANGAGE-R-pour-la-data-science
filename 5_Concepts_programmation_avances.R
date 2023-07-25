# # # # # # # # # # # # # # # # # # # # # # # # # # 
# Concept de programmation avances
# # # # # # # # # # # # # # # # # # # # # # # # # # 

# 1 - Boucles

# FOR  
for(i in 1:5){
  print(i)
}

Vect <- c(1, 3, 90, 89)

for(i in 1:length(Vect)){
  print(Vect[i])
}

# WHILE  

i <- 1

while(i < 10){
  print(i) 
  i <- i + 1 
}

vec <- c(5, 8, -2, 10, -5, 7)
i <- 1
while(vec[i] >= 0) {
  i <- i + 1
}
print(paste("Le premier nombre négatif est :", vec[i]))

# 2 - Fonctions

calculer_moyenne <- function(x) {
  
  n <- length(x)
  moyenne <- sum(x) / n
  return(moyenne)
}

x <- c(1, 2, 3, 4, 5)
# renvoie 3
res <- calculer_moyenne(x) 
# renvoie 3
mean(x)


est_pair <- function(nombre) {
  
  if (nombre %% 2 == 0) {
    return(TRUE)
    
  } else {
    return(FALSE)
    
  }
}
# renvoie TRUE
est_pair(4) 
# renvoie FALSE
est_pair(3) 

Vect <- c(10,3,99,65,43,9,78,1)

Nombre_pair <- function(vec) {
  nombre <- c() # Création d’un vecteur vide
  for(i in 1:length(vec)){
    if (vec[i] %% 2 == 0) {
      nombre <- c(nombre, vec[i]) # actualisation du vecteur vide
    }
  }
  return(nombre)
}
Nombre_pair(Vect) # affiche 10 et 78


# 3 - Famille apply
# Créer une matrice 3 x 3
matrice <- matrix(1:9, ncol = 3)

# Résultat : [6 15 24]
res <- apply(matrice, 2, sum) 

# Résultat : [2 5 8]
res <- apply(matrice, 1, mean)

Ma_liste <- list(L1=rnorm(5),L2=1:5, L3=runif(5))
# Renvoie une liste contenant les moyennes des 3 listes
lapply(Ma_liste, mean) 

# 4 - dplyr

# Installation et chargement
install.packages("dplyr")
library(dplyr)
library(MASS)

# Aperçu des données starwars
head(starwars)

# 87 lignes et 14 colonnes
dim(starwars)

# Filtre les données selon la variable « species » avec modalité « Droid »
starwars %>%  filter(species == "Droid")

# Sélection des colonnes name et de toutes celles qui finissent par color
starwars %>% select(name, ends_with("color"))

# Création d’une nouvelle variable bmi et sélection des 
# variables name à mass + imc (body mass index)
starwars %>% 
  mutate(imc = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, imc)

# Regroupement des données par espèces,
# calcul le nombre d’individus et la masse moyenne
# par espèces puis filtrage des données en fonction du 
# nombre d’individu et de la masse. Enfin les données sont réorganisées 
# par ordre croissant selon la valeur de la masse
starwars %>%
  group_by(species) %>% 
  summarise(
    n = n(),
    mass_moyenne = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1, mass_moyenne > 50) %>% 
  arrange(mass_moyenne)


# 4 - ggplot2

install.packages("ggplot2")
library(ggplot2)


# Diagramme à barres 
df <- data.frame(letters = LETTERS,
                 order = 1:26)
ggplot(df, aes(x = letters, y = order)) +
  geom_bar(stat = "identity", width = 0.7)+
  labs(x = "Letters", y = "Alphabet order")+
  ggtitle("Barplot")+
  theme_classic()

# Line plot pour une série temporelle
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line() +
  labs(x = "Year", y = "Unemployment Rate")+
  ggtitle ("Line plot") +
  theme_classic()

# Nuage de points
ggplot(mtcars, aes(x = mpg, y = hp)) +
  geom_point() +
  labs(x = "Miles Per Gallon", y = "Horsepower")+
  ggtitle("Scatter plot")+
  theme_classic()

# Boxplot
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot() +
  labs(x = "Cut", y = "Price")+
  ggtitle("Boxplot")+
  theme_classic()





