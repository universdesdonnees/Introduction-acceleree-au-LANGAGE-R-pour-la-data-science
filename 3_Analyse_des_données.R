# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 3 - Analyse des données avec R
# # # # # # # # # # # # # # # # # # # # # # # # # # 

# Permet d'avoir toujours les mêmes valeurs tirées au sort

set.seed(1991)

###
### Les métriques usuelles
###

# Création d’un jeu de données fictives 
# Création d’un jeu de données fictives 
# La fonction « sample » permet de tirer des valeurs aléatoirement comprises dans un intervalle donné.
# Exemple : pour la variable « age », 40 valeurs comprises entre 18 et 100 sont tirées au sort.
# La fonction « rbinom » permet de générer n expériences de Bernoulli. 
# Exemple : pour la variable « pratique du sport » sont générées 40 valeurs avec une probabilité d’environ 60% d’obtenir « 1 » soit un succès.

DF <- data.frame(
  genre = c(rep("Homme", 20), rep("Femme", 20)),
  age = sample(18:100, 40),
  poids = sample(60.8:150.6, 40),
  groupe = c( rep("Groupe1", 10), 
              rep("Groupe2", 10), 
              rep("Groupe3", 10), 
              rep("Groupe4", 10)),
  pratique_du_sport = rbinom(40,1,0.6))

###### Description pour les variables numériques (age et poids)
# Moyenne
mean(DF$age)
# Médiane
median(DF$age)
# Quantile 
quantile(DF$age, p=0.25) # Quantile d'ordre 0.25
quantile(DF$age, p=0.75) # Quantile d'ordre 0.75
#	Minimum
min(DF$poids)
# Maximum
max(DF$poids)
# Echelle
range(DF$poids)
# Variance
var(DF$poids)
# Ecart-type 
sd(DF$age)
# Covariance
cov(DF$age, DF$poids)

# Résumé statistique 
# Pour les variables numériques R calcule automatiquement 
# les métriques usuelles  avec la fonction "summary"
summary(DF)


###### Description pour les variables qualitatives 
# (genre, groupe, pratique du sport)

# Table de fréquence
table(DF$genre)
table(DF$groupe)
table(DF$pratique_du_sport)

# Table de contingence : tableau croisé
table(genre = DF$genre, sport = DF$pratique_du_sport) 

# Table de proportion
prop.table(table(DF$genre))
prop.table(table(DF$groupe))
prop.table(table(DF$pratique_du_sport))

###### Informations par modalités 
# # summary de l'age selon les modalités associées au genre 
tapply(DF$age, DF$genre, FUN = summary) 

###
### visualisation graphique usuelles
###

# 1 - Représentation variable numérique
par(mfrow=c(2,2))
# Boxplot par défaut avec R
boxplot(DF$age,
        main= "Boxplot variable :\n age", 
        ylab = "Age")

# Histogramme par défaut avec R
hist(DF$poids,
     main= "Histogramme variable continue :\n poids", 
     ylab = "Nombre de personnes", xlab = 'Poids', 
     breaks = 5)

# Barplot par défaut avec R
barplot(table(DF$pratique_du_sport),
        ylab = "Nombre de personnes",
        xlab = "Pratique du sport", 
        names = c("Non", "Oui"),
        main ="Barplot variable discrète :\n pratique du sport")

# Nuage de points entre l'age et le poids
plot(poids ~ age, data = DF, 
     ylab = "Poids",
     xlab = "Age", 
     main = "Nuage de points de l'age en \n fonction du poids")

graphics.off()

# 2 - Représentation variable qualitative
barplot(table(DF$genre), 
        ylab = "Nombre de personnes",
        xlab = "Genre", 
        main = "Barplot variable qualitative : genre")

# 3 - Représentation de deux variables qualitatives
barplot(table(DF$pratique_du_sport, DF$genre),
        beside = TRUE,
        ylab = "Nombre de personnes",
        xlab = "Genre", 
        main = "Barplot 2 variables qualitatives :\n genre et pratique du sport")
legend(title = "Pratique du sport",
       x = 0.8, y = 10, 
       legend = c("Non", "Oui"),
       pch = 15,  
       col = c("black", "grey"), 
       bty = "n",
       ncol = 1)

# 4 -  Représentation variable genre selon l'age et les modalités de genre
boxplot(age ~ genre, 
        data = DF,
        main = "Boxplot de l'age \n par modalités de genre",  
        ylab = "Age", 
        xlab = "Genre")


# Sauvegarde graphique en png : application aux données mtcars

png(file = "plot.png", width = 720, height = 480) 
# "plot.png" : nom donné au fichier
# Les arguments width et height spécifient la taille de l'image en pixels.
plot(mtcars$wt, mtcars$mpg)
dev.off()

# Sauvegarde graphique en jpeg : application aux données mtcars
jpeg(file = "plot.jpeg", width = 720, height = 480)
plot(mtcars$wt, mtcars$mpg)
dev.off()

###
### Inférence statistique
###

##### 1 -  Student (test paramétrique)

# 1.1. Student's t-Test : comparer une moyenne observée à une valeur théorique # "mu"
# Génération de 50 valeurs tirées aléatoirement sous une loi normale de 
# moyenne = 10 et d’écart-type = 0.5
x <- rnorm(50, mean = 10, sd = 0.5)

# Tester la normalité
shapiro.test(x) # P-value > 0.05 donc suit une loi normale

# Test de student
t.test(x, mu=10) # P-value > 0.05, moyenne égale à 10

# 1.2. Student's t-Test : comparer les moyennes observées de 2 échantillons 
# indépendants 
x <- rnorm(50, mean = 10, sd = 0.5)
y <- rnorm(50, mean = 5, sd = 0.5)

# Tester la normalité des échantillons indépendants
shapiro.test(x) # P-value > 0.05 ! ok 
shapiro.test(y) # P-value > 0.05 ! ok 
t.test(x, y) # P-value < 0.05, moyennes différentes

# 1.3. Student's t-Test : comparer les moyennes observées de 2 échantillons 
# dépendants 
x1 <- rnorm(50, mean = 10, sd = 0.5)
x2 <- rnorm(50, mean = 10, sd = 0.5)

t.test(x1, x2, paired = TRUE) # P-value > 0.05, pas de différence 

###  Récupérer les valeurs spécifiques du test 
res <- t.test(x,y)
res$p.value # Affichage de la P-value
res$parameter # Affichage du degré de liberté
res$statistic # Affichage  de la statistique t

##### 2 - Wilcoxon Signed Rank Test (équivalent Student mais non paramétrique)

# 2.1. Wilcoxon : comparer une moyenne observée à une valeur théorique "mu"
y <- c(0.878, 0.647, 0.598, 2.05, 1.06, 1.29, 1.46, 3.14, 1.54)
wilcox.test(y, mu=3) # P-value < 0.05, moyenne différente de 3

# 2.2. Wilcoxon : comparer moyennes observées de 2 échantillons indépendants 
x <- c(0.80, 0.83, 1.89, 1.04, 1.45, 1.38, 1.91, 1.64, 0.73, 1.46)
y <- c(1.15, 0.88, 0.90, 0.74, 1.21)
wilcox.test(x, y)

# 2.3. Wilcoxon : comparer les moyennes observées de 2 échantillons dépendants 
x1 <- rnorm(50, mean = 10, sd = 0.5)
x2 <- rnorm(50, mean = 9, sd = 0.5)
wilcox.test(x1, x2, paired = TRUE)

###  Récupérer les valeurs spécifiques du test 
res <- wilcox.test(x,y)
res$statistic # Affichage  de la statistique W
res$p.value # Affichage de la P-value

##### 3 - Pearson's Chi-squared Test (test paramétrique)

# 3.1.  Pearson's Chi-squared : Indépendance entre 2 variables qualitatives
M <- as.table(rbind(c(762, 327, 468), 
                    c(484, 239, 477)))  # Table 2 lignes/3 colonnes
dimnames(M) <- list(genre = c("F", "M"), 
                    parti_politique = c("Gauche","Centre","Droite"))
chisq.test(M) # P-value < 0.05, dépendance entre le parti politique et le genre

# 3.2.  Pearson's Chi-squared : Adéquation à une répartition théorique
x <- c(A = 20, B = 15, C = 25)
chisq.test(x) # P-value > 0.05,compatible avec une répartition théorique de 20 

# 3.3.  Pearson's Chi-squared : Homogénéité des répartitions pour 3 # échantillons indépendants 
M <-  matrix(c(58, 22, 39, 41, 49, 31),
             nrow = 2, 
             dimnames = list(Resultat = c("Admis", "Ajournés"), 
                             Prof = c("A","B","C")))
###  Récupérer les valeurs spécifiques du test 
Xsq <- chisq.test(M)
Xsq$statistic  # la statistique du Chi2.
Xsq$parameter  # le nombre de degrés de libertés
Xsq$p.value    # Affichage P-value 
Xsq$observed   # Effectifs observés (M)
Xsq$expected   # Effectifs attendus sous H0
# P-value < 0.05, donc les répartitions ne sont pas homogènes 
# entre les 3 échantillons

##### 4 - Fisher's Exact Test (test non paramétrique)
# Equivalent du Chi-2 d'indépendance et d'homogénéité 
Job <- matrix(c(1,2,1,0, 3,3,6,1, 10,10,14,9, 6,7,12,11), 4, 4,
              dimnames = list(income = c("< 15k", "15-25k", "25-40k", ">40k"),
                              satisfaction = c("VeryD", "LittleD","ModerateS", "VeryS")))
ft <- fisher.test(Job)
ft$p.value # P-value > 0.05, indépendance entre le salaire et la satisfaction au travail

##### 5 - Anova (test paramétrique)
# comparaison des moyennes de plusieurs échantillons (> 2)
# Application aux données : PlantGrowth
head(PlantGrowth)

# Test pour vérifier l'égalité des variances
bartlett.test(weight ~ group, data = PlantGrowth)
# P-value > 0.05 donc pas de différence significative entre les variances

# On peut faire l'Anova sinon Kruskal-Wallis Rank Sum Test.
res.aov <- aov(weight ~ group, data = PlantGrowth)
summary(res.aov)
# P-value < 0.05 donc différences significatives 
# tests 2 à 2 
TukeyHSD(res.aov)
# La différence existe entre le traitement 1 et 2
# avec une P-value ajustée < 0.05

##### 6 - Kruskal-Wallis Rank Sum Test (test non paramétrique)
# Equivalent de l'anova pour la comparaison de moyennes de plusieurs 
# échantillons (> 2)
res.kt <- kruskal.test(weight ~ group, data = PlantGrowth)
res.kt
# tests 2 à 2 avec correction de Benjamini & Hochberg
pairwise.t.test(PlantGrowth$weight, PlantGrowth$group,
                p.adjust.method = "BH")
# voir ?p.adjust pour voir les autres méthodes d'ajustement disponibles


##### 7 - Kolmogorov And Smirnov Test
# Compare si deux échantillons suivent la même distribution
x <- rnorm(50) # tirage aléatoire de nombres dans une loi normale
y <- runif(50) # tirage aléatoire de nombres dans une loi uniforme
ks.test(x, y)  # P-value < 0.05, donc pas la même distribution

x <- rnorm(50)
y <- rnorm(50)
ks.test(x, y) # P-value > 0.05, même distribution

##### 8 - Test for Association/Correlation Between Paired Samples 
# étude d'un lien linéaire entre deux variables numériques
# Application aux données : mtcars
head(mtcars)
# Check de la normalité
shapiro.test(mtcars$mpg) # => P-value = 0.1229
shapiro.test(mtcars$wt) # => P-value = 0.09
# Les P-values > 0.05 donc Pearson sinon Spearman ou Kendall
res.cor <- cor.test(mtcars$mpg ,mtcars$wt,
                    method="pearson")
# exemple : res.cor <- cor.test(mtcars$mpg ,mtcars$wt, method="spearman")

res.cor$p.value # P-value < 0.05 donc lien significatif
res.cor$estimate # Coefficient de corrélation = -0.867
# Association linéaire négative entre le poids et le nombre de km fait par # litre d'essence consommé

plot(mpg ~ wt, data = mtcars,
     xlab = "Poids" , 
     ylab = "km/Litre" ,
     main = "Nuage de points entre la consommation d'essence \n
     et le poids du véhicule")
# Plus le véhicule est lourd, moins il est possible de faire des kilomètres avec un litre d'essence

