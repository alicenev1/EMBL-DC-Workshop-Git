# we will be talking about data.fraimes

# Let's import some data
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

library(tidyverse)
#come leggere un file csv con molte info - potrei usare anche read.csv()
surveys <- read_csv("data_raw/portal_data_joined.csv")

head(surveys)

#per vedere un csv come tabella nel pannello in alto
View(surveys)

#informations about table structure, primi valori di ogni colonna, estensione, etc
str(surveys)

#numero e nome di colonne e righe, e come chiedere le singole informazioni
dim(surveys)
nrow(surveys)
ncol(surveys)
tail(surveys)
names(surveys)
colnames(surveys)
rownames(surveys)

#informations about mean, median, min, max per ogni colonna
summary(surveys)

#indexing and subsetting (prima metto le righe poi le colonne)

surveys[1, 6]
#se non dico la colonna o la riga, mi da tutte le colonne per quella riga, o viceversa
surveys [ , 6]
surveys [1, ]
#se uso la c posso specificare le colonne e/o le righe, più di una, di cui voglio vedere info.
surveys [c(1, 2, 3), c (5,6)]
surveys [c(1, 2, 3), ]
#se sono colonne consecutive posso usare i due punti ed evitarmi la c
surveys [1:3, 5:6]

surveys[ , -1]
#posso anche specificare con il nome della colonna, in due diversi modi, ma così resta una tabella
surveys[ , "sex"]
surveys["sex"]
#così te la ritrovi come vettore
surveys$sex


surveys_200 <- surveys[200, ]
surveys[nrow(surveys), ]
surveys[nrow(surveys)/2, ]

#factors - guardo struttura, guardo come è la colonna, la trasformo in un fattore
str(surveys)
surveys$sex
surveys$sex <- factor(surveys$sex)
surveys$sex

levels(surveys$sex)
nlevels(surveys$sex)

sex <- factor(c("male", "female", "female", "male"))
sex <- factor(sex, levels = c("male", "female"))

#challenge - trasforma taxa e genus in fattori
surveys$taxa <- factor(surveys$taxa)
surveys$genus <- factor (surveys$genus)
surveys$taxa
surveys$genus

#quanti genera in gus column? ovvero quanti livelli
nlevels(surveys$genus)

#quanti rabbit in taxa. Primo sistema ma il secondo funziona eprchè adesso li ho dati come fattori
sum(surveys$taxa == "Rabbit")
summary(surveys)

# convert factors come caratteri o numero
sex
as.character(sex)

year_fct <- factor(c(1990, 1983, 1977, 1997))
year_fct

#option1
as.numeric(year_fct)
#option2
as.numeric(as.character(year_fct))
as.numeric(levels(year_fct))[year_fct]

as.factor(c(1990, 1983, 1977, 1997))

#Renaming factors
plot(surveys$sex)
#mi accorgo di NAs che non sono plottati
summary(surveys$sex)
#rinomino, mi accorgo ora che Na è un livello e lo rinomino
sex <- surveys$sex
levels(sex)
sex <-   addNA(sex)
levels(sex)

levels(sex)[3] <- "undetermined"
levels(sex)
sex

plot(sex)

levels(sex) [1:2] <- c("female", "male")
plot(sex)

sex <- factor(sex, levels = c("undetermined", "female", "male"))
plot(sex)

