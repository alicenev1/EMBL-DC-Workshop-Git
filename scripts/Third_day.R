library(tidyverse)
surveys <- read_csv("data_raw/portal_data_joined.csv")

str(surveys)
View(surveys)

#in questo modo posso selezionare le colonne che voglio vedere
select(surveys, plot_id, species_id, weight)

#in questo modo posso selezionare le colonne che non voglio vedere
select(surveys, -record_id, -species_id)

#in questo modo posso filtrare per un valore in una colonna
filter(surveys, year == 1995)

filter(surveys, year == 1995, sex == "M")

surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
surveys2

surveys_sml <- select(surveys2, species_id, sex, weight)

surveys_sml <- select(surveys2, species_id, sex, weight)
surveys_sm2 <- select(filter(surveys, weight < 5), species_id, sex, weight)

#il comando %>% accorcia le operazioni, il risultato del primo comando diventa input del secondo
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

#option 1
surveys_1995 <- filter(surveys, year < 1995)
select(surveys_1995, year, sex, weight)

#option 2
surveys %>%
  filter(year < 1995) %>%
  select(year, sex, weight)

#aggiungere una colonna dove un valore viene convertito in altra misura
surveys %>%
  mutate(weight_kg = weight/1000) %>%
  View()

surveys %>%
  mutate(weight_kg = weight/1000, weight_lb = weight_kg * 2.2) %>%
  head()

#posso convertire il valore, togleindo prima gli NA
surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000, weight_lb = weight_kg * 2.2) %>%
  head()


#split, apply, combine
#dal file survey, creo gruppi per sesso, e poi le chiedo di farmi la media del peso
#chiedo che questa info va in altra colonna, rimuovendo Na 
surveys %>%
  group_by(sex)%>%
  summarise(mean_weight = mean(weight, na.rm = T))

#con !is.na rimuovo NA in sex, con na.rm rimuovo in weight
surveys %>%
  filter(!is.na(sex)) %>%
  group_by(sex)%>%
  summarise(mean_weight = mean(weight, na.rm = T))

surveys %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T)) %>%
  tail()

# dato che ho NA
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T)) %>%
  tail()

#print ti fa vedere più row
surveys %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T)) %>%
  print(n=15)

surveys %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T), min_weight = min(weight)) %>%
  arrange(min_weight)

#desc = descending order
surveys %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T), min_weight = min(weight)) %>%
  arrange(desc(min_weight))

#per inserire quickly %>% usa ctrl+shift+M
surveys %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight, na.rm = T), min_weight = min(weight, na.rm = T)) %>%
  arrange(min_weight) 

#conta il numero di righe aventi quel valore in una nuova colonna n che crea
surveys %>% 
  count(sex)

surveys %>% 
  count(sex, species)

surveys %>% 
  count(sex, species) %>% 
  arrange(species, desc(n))

#se vuoi che questo diventi un gruppo nominabile, puoi farlo diventare un data
surveys_new <- surveys %>% 
  count(sex, species) %>% 
  arrange(species, desc(n))
View(surveys_new)

#challenge1: how many animals were caught in each plot_type surveyed?
surveys %>%
  count(plot_type)

#challenge2: use group_by() and summarise() to find mean, min, max di hindfoot_lenght per species and number of observations
surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarise(
    mean_hindfoot_length = mean(hindfoot_length), 
    min_hindfoot_length = min(hindfoot_length), 
    max_hindfoot_length = max(hindfoot_length), 
    n = n()
  ) %>% 
  View()

#challenge3:
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(year) %>%  
  filter(weight == max(weight)) %>%
  select(year, genus, species_id, weight) %>% 
  arrange(year) %>% 
  unique()

#trasformo una tabella da verticale a orizzontale, specificando cosa usare come nome colonna e cosa come valore
surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarise(mean_weight = mean(weight))

View(surveys_gw)
str(surveys_gw)

surveys_gw %>% 
  pivot_wider(names_from = genus, values_from = mean_weight)
#vedo che ci sono NA e li sostituisco con 0

surveys_gw %>% 
  pivot_wider(names_from = genus, values_from = mean_weight, values_fill = 0)
