# # # # # # # # # # # # # # # # # # # # # # # # # # 
# Introduction au machine learning
# # # # # # # # # # # # # # # # # # # # # # # # # # 

# 1 - Modele regression linéaire simple et multiple

# Lien linéaire entre les variables
plot(mpg ~ wt, data = mtcars,
     xlab = "Poids" , 
     ylab = "km/Litre" ,
     main = "Nuage de points entre la consommation d'essence \n
     et le poids du véhicule")

# # # # # # # #  Modele de régression simple # # # # # # # # 

modele1 <- lm(mpg ~ wt, data = mtcars)
summary(modele1)

# Vecteur des coefficients
coeff <- coefficients(modele1) 

# Equation du modèle linéaire
eq <- paste0("mpg = ", round(coeff[2],1), "*wt + ", round(coeff[1],1)) 

# intervalle de confiance à 95% des coefficients 
exp(confint(modele1))

# Visualisation de l’ajustement du modèle aux données observées
plot(mpg ~ wt, data = mtcars,
     xlab = "Poids" , 
     ylab = "km/Litre" ,
     main = paste0("Droite de régression : \n", eq))
# Ajoute une droite sur le graphique précédent
abline(modele1, col="blue")


# # # # # # # # Modele regression multiple # # # # # # # # 

modele2 <- lm(mpg ~ hp + wt + gear + disp, 
              data = mtcars)
summary(modele2)

# Homoscedasticité (homogeneité de la variance)
par(mfrow=c(2,2))
plot(modele1)
par(mfrow=c(1,1))

# Performances prédictives du modèle 

# R carré
r_squared <- summary(modele2)$r.squared
r_squared

# Erreur quadratique moyenne
mse <-  mean((modele2$fitted.values - mtcars$mpg)^2)
mse

# Erreur absolue moyenne
mae <- mean(abs(modele2$fitted.values - mtcars$mpg))
mae

# Validation croisée

set.seed(100)

# Nombre de ligne de mtcars
nrow(mtcars)

# échantillon de 20 lignes de mtcars
split <- sample(nrow(mtcars), 20)

# définition de l'échantillon d'apprentissage
data_apprentissage <- mtcars[split, ] # 20

# définition de l'échantillon de validation
data_validation <- mtcars[-split, ]

# Entraînement du modèle
modele3 <- lm(mpg ~ hp + wt + gear + disp, data = data_apprentissage)
summary(modele3)

# prédictions de nouvelles valeurs par le modèle
predictions <- predict(modele3, newdata = data_validation)

# Comparaison entre les valeurs prédites et les observées
df <- data.frame(
  valeurs_predites = predictions,
  valeurs_observee = data_validation$mpg)
df

# calculer l'erreur MSE pour les données d'apprentissage
mse_apprentissage <-  mean((modele3$fitted.values - data_apprentissage$mpg)^2)
mse_apprentissage

# calculer l'erreur MSE pour les données de validation
mse_validation <- mean((predictions - data_validation$mpg)^2)
mse_validation


# 2 - Modele regression logistique

# install.packages("pROC")
# install.packages("ROCR")
# install.packages("caret")
library(pROC)
library(ROCR)
library(caret)

boxplot(wt~ am, data = mtcars, 
        main = "Boxplot du poids par modalités de 
        transmission d'un véhicule",  
        ylab = "Poids", 
        xlab = "Type de transmission")

# Définition d’une variable binaire 
# 0 : transmission Automatique
# 1 : transmission Manuelle
mtcars$am

# # # # # # # # Modèle de régression logistique simple # # # # # # # # 

Modele_logistique <- glm(am ~ wt, data = mtcars, 
                         family = "binomial")
summary(Modele_logistique)

# log coefficient du modèle
coef(Modele_logistique) 

# coefficients
exp(coef(Modele_logistique)) 

# intervalle de confiance des coefficients
exp(confint(Modele_logistique)) 

# # # # # # # # Modèle de régression logistique multiple # # # # # # # # 

Modele_logistique_multiple <- glm(am ~ mpg + hp + wt + disp, data = mtcars, 
                                  family = "binomial")

# coefficients
round(exp(Modele_logistique$coefficients),2)

# intervalle de confiance à 95% des coefficients
round(exp(confint(Modele_logistique)),5)

# Prédictions
predictions <- predict(Modele_logistique, newdata = mtcars, 
                       type = "response")

# Choix du seuil de probabilité supérieur à 0.5 
predictions <- ifelse(predictions > 0.5, 1, 0)

# Définition des facteurs
predictions_class <- factor(predictions, 
                            labels = c("Manuelle", "Automatique"),
                            levels = c(1,0))
observation_class <- factor(mtcars$am, 
                            labels = c("Manuelle", "Automatique"),
                            levels = c(1,0))
# Table de confusion
result <- confusionMatrix(predictions_class, observation_class, 
                          positive = "Manuelle")
print(result)
# AUC
predictions <- predict(Modele_logistique, type = "response")

mtcars_ROC <- roc(observation_class, predictions,
                   plot=TRUE,
                   print.auc=TRUE,col="blue",
                   lwd =4,legacy.axes=TRUE,main="Aire sous la courbe ROC")

# intervalle de confiance 95% de l'auc
ci(mtcars_ROC)

# Génération de 500 nouvelles valeurs de poids : wt
new_data <- data.frame(
  wt  = seq(min(mtcars$wt), max(mtcars$wt),len=500))

# Prédictions de am associées aux nouvelles wt
new_data$am = predict(
  Modele_logistique, new_data, type="response")

# Graphique
plot(am ~ wt, data = mtcars,
     main = "Modèle de régression logistique du poids 
     par modalités de transmission d'un véhicule",  
     xlab = "Poids", 
     ylab = "Type de transmission")
lines(am ~ wt, data= new_data, lwd=2, col="blue")


# 3 - arbre de classification

# install.packages("rpart")
# install.packages("rpart.plot")
# install.packages("rattle")

library(rpart)
library(rattle)
library(rpart.plot)


# 3 - Arbre de classification 

# # # # # # # # Modèle de partition # # # # # # # # 

ptitanicTree <- rpart(survived ~ ., data = ptitanic) 

# Représentation de l’arbre 
fancyRpartPlot(ptitanicTree)

# Matrice de confusion et métriques
predictions_class <- predict(ptitanicTree, type = "class")
result <- confusionMatrix(predictions_class, ptitanic$survived, 
                          positive = 'survived')
print(result)

# Prédictions survie et déces
predictions <- predict(ptitanicTree, type = "prob")
head(predictions)
predictions_survie <- predictions[,2]

# AUC
titanic_ROC <- roc(ptitanic$survived, predictions_survie,
                   plot=TRUE,
                   print.auc=TRUE,col="blue",
                   lwd =4,legacy.axes=TRUE,main="Aire sous la courbe ROC")

# intervalle de confiance 95%
ci(titanic_ROC)


# 4 - Clustering

# install.packages("cluster")
# install.packages("clusterSim")
# install.packages("fpc")
library(cluster)
library(clusterSim)
library(fpc)

set.seed(123)

# Génération des données
x1 <- rnorm(50, mean = 0, sd = 1)
y1 <- rnorm(50, mean = 0, sd = 1)
x2 <- rnorm(50, mean = 5, sd = 1)
y2 <- rnorm(50, mean = 5, sd = 1)
x <- c(x1, x2)
y <- c(y1, y2)

donnees <- data.frame(x, y)

# Visualisation des données 
plot(x, y, 
     main = "Nuage de points y = f(x)")

# Transformation des données :  normalisation des données
my_data <- scale(donnees)

# # # # # # # # Modele de clustering  # # # # # # # # 
modele_kmeans <- kmeans(my_data, centers = 2)

# Visualisation de résultats
plot(my_data, col = modele_kmeans$cluster)
points(modele_kmeans$centers, col = 1:2, pch = 8, cex = 2)

# Somme des carrés des distances entre chaque observation
sse <- sum(modele_kmeans$withinss)

# Optimisation du nombre de cluster
clustering.ch <- kmeansruns(my_data, krange=1:10, criterion="ch")
clustering.ch$bestk

clustering.asw <- kmeansruns(my_data, krange=1:10, criterion="asw")
clustering.asw$bestk

clustering.ch$crit
clustering.asw$crit

critframe <- data.frame(k=1:10, 
                        ch=scale(clustering.ch$crit),
                        asw=scale(clustering.asw$crit))

plot(critframe$k, critframe$ch,
     type = "b", frame = TRUE, pch = 19, 
     col = "red", 
     xlab = "Nombre de cluster(k)", ylab = "Score")
lines(critframe$k, critframe$asw, pch = 18,
      col = "blue", type = "b", lty = 2)
legend("topright", 
       legend=c("Calinski-Harabasz index", "Silhouette Score (moyenne)"),
       col=c("red", "blue"), lty = 1:2, cex=0.8)


# 5 - Regression de Poisson : Modelisation de variables discretes
# Télécharger les données : https://github.com/mwitiderrick/insurancedata/blob/master/insurance_claims.csv

# Chargement des données de sinistres
insurance_claims <- read.csv("Data/insurance_claims.csv", header = TRUE)
head(insurance_claims)

# Modélisation du nombre de sinistres en fonction de l'age
# La ville, et la police annuelle
model <- glm(total_claim_amount ~ age + incident_city + policy_annual_premium, 
             data = insurance_claims, family = "poisson")

summary(model)
coef(model) 
exp(coef(model)) 
exp(confint(model)) 


# 6 - Ordinal Logistic Regression

# install.packages("ordinal")

library(ordinal)

data(wine)
head(wine)

model <- clm(rating ~ temp + contact, data = wine)
summary(model)

coef(model) 
exp(coef(model))
exp(confint(model)) 

# 7 - Time Series Data - ARIMA Model

# install.packages("forecast")

library(forecast)

model <- auto.arima(AirPassengers)
summary(model)

# Visualisation des données AirPassengers
ts.plot(AirPassengers)

# Valeurs prédites par le modèle
AR_fit <- model$fitted

# Ajout des valeurs prédites par le modèle sur le graphique
points(AR_fit, type = "l", col = 2, lty = 2)
legend("topleft", 
       legend=c("Valeurs observées", "Valeurs prédites"),
       col=c("black", "red"),"left",
       lty = 1:2, cex=0.8)

