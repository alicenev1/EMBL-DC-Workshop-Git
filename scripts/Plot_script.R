#ggplot2 - fare immagini - aes sta per aesthetic

plt <- ggplot(
  data = surveys_complete,
  mapping = aes(x = weight, y = hindfoot_length)
)
plt
str(plt)

#inseriamo il + per inserire altre funzioni e livelli
plt +
  geom_point()

plt +
  geom_point() +
  ggtitle("My first plot!")

#1. define ggplot object
#plt <- ggplot(data = <data.frame>, mapping = <aestethics>)
# x aesthetic
# y aesthetic
# color aesthetic
# shape aesthetic
#....
#2. add geometry layer(s)
# geometry functions have predictable names
# geom_ {point, line, bar, histogram, violin, hex, ....} 

plt <- ggplot(data = surveys_complete, mapping = aes(x = weight, y= hindfoot_length)) +
  geom_point()
  
plt +
  ggtitle ("Weight vs hindfoot length")

#per risolvere il problema di grafici troppo densi
install.packages("hexbin")
library(hexbin)
?geom_hex

ggplot(data = surveys_complete, mapping = aes (x = weight, y = hindfoot_length)) +
  geom_hex()

?geom_point

#posso trasformare i punti del grafico in cose meno dense 
#(alpha is trasparency, and 0,1 = 10%)
ggplot(data = surveys_complete, mapping = aes(x = weight, y= hindfoot_length)) +
  geom_point(alpha = 0.1)
#posso trasformare i punti del grafico in cose colorate
ggplot(data = surveys_complete, mapping = aes(x = weight, y= hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")

ggplot(data = surveys_complete, mapping = aes(x = weight, y= hindfoot_length)) +
  geom_point(alpha = 0.25, aes(color = species_id))

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = weight, 
    y= hindfoot_length,
    color = species_id)) +
    geom_point (alpha = 0.25)

#Challenge: scatterplot weight vs species_id, color by plot_type
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight, 
    color = plot_type)) +
  ggtitle ("Scatterplot") +
  geom_point()

#per migliorarlo
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)
  ) +
  geom_boxplot()

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)) +
  geom_boxplot() +
  geom_jitter (alpha = 0.3, color = "salmon") #adding a little value for each x coord

#rimuovere outlier dandogli nessuna forma e rimuovere il backgroud bianco dei box
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)) +
  geom_boxplot( outlier.shape = NA, fill = NA) +
  geom_jitter (alpha = 0.3, color = "salmon") 

#se inverto l'ordine il boxplot appare sopra i punti (al contrario rispetto a prima)
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)) +
  geom_jitter (alpha = 0.3, color = "salmon") +
  geom_boxplot( outlier.shape = NA, fill = NA)

#challenge: produce a violin plot of weight by species_id
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)) +
  geom_violin (fill = "blue")

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= weight)) +
  geom_violin () +
  scale_y_log10() +
  ylab ("Weight (log10)")

#challenge: make a boxplot + jittered scatterplot of 
#hindfoot_length by species_id. Boxplot should in front of the dots and
#filled with white

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= hindfoot_length)) +
  geom_jitter(alpha = 0.3, aes(color = plot_id)) +
  geom_boxplot(outlier.shape = NA, fill = "white")
  
#rgb: red, green, blue. rgb (red= .3, green= .3, blue = .3)
#dedede hemadecimal code
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y= hindfoot_length)) +
  geom_jitter(alpha = 0.3, aes(color = factor(plot_id))) + #rgb(.3,.3,.3)) +
  geom_boxplot(outlier.shape = NA, fill = "white")

#nuovo grafico
yearly_count <- surveys_complete %>% 
  count(year, genus)
View(yearly_count)

ggplot(data = yearly_count, mapping = aes(x= year, y = n)) +
  geom_line ()

ggplot(
  data = yearly_count, 
  mapping = aes(
    x= year, 
    y = n, 
    group = genus)) +
  geom_line ()

ggplot(
  data = yearly_count, 
  mapping = aes(
    x= year, 
    y = n, 
    color = genus)) +
  geom_line ()

yearly_count %>% 
  ggplot(mapping = aes(x= year, y = n, color = genus)) +
  geom_line ()


yearly_count_graph <- surveys_complete %>% 
  count(year, genus) %>% 
  ggplot(mapping = aes(x= year, y = n, color = genus)) +
  geom_line ()

yearly_count_graph

#come graficare meglio
ggplot(data = yearly_count, 
       mapping = aes(
         x = year, 
         y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

#aggiungere anche il parametro sex e colorarlo
surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
       mapping = aes(
         x = year, 
         y = n,
         color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

# fare subplot del sex, organizzarlo diversamente, facet_grid
surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_grid(
    rows = vars(sex),
    cols = vars(genus))

#posso anche accorparli, specificando solo colonne o solo righe
surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_grid(
    rows = vars(genus))

surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_grid(
    cols = vars(genus))


#posso modificare diversi parametri del grafico, come voglio, e salvare
#base_size nomi titoli
plottino <- surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  theme_bw(base_size = 14)
ggsave(filename = "data/plottino.pdf", 
       plot = plottino,
       width = 10,
       height = 10)

plottino_2 <- surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  xlab("Year of observation") +
  ylab ("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom",
    aspect.ratio = 1)
plottino_2
ggsave(filename = "data/plottino_2.pdf", 
       plot = plottino_2,
       width = 10,
       height = 10)

#posso mettere legend al bottom
#mettere l'aspetto squared
#angolare il testo asse x
#rimuovere la griglia dietro
plottino_3 <- surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x = year, 
      y = n,
      color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  xlab("Year of observation") +
  ylab ("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom",
    aspect.ratio = 1,
    axis.text.x = element_text(
      angle=45, 
      hjust = 1),
    panel.grid = element_blank())
ggsave(filename = "data/plottino_3.pdf", 
       plot = plottino_3,
       width = 10,
       height = 10)

#cambi color scale, e sistemi legenda
#metti plot.title (0 a sinistra, 1 a destra, 0.5 al centro)
plottino_4 <- surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  scale_color_manual(
    values = c("purple", "black"), 
    labels = c("Female", "Male"),
    name = "Sex") +
  xlab("Year of observation") +
  ylab ("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom",
    aspect.ratio = 1,
    axis.text.x = element_text(angle=45, hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank())
ggsave(filename = "data/plottino_4.pdf", 
       plot = plottino_4,
       width = 10,
       height = 10)

#posso anche avere x e y visibile in ogni plot, scales = "free_y", or "free_x", or "free"
plottino_5 <- surveys_complete %>% 
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(
    facets = vars(genus),
    scales = "free") +
  scale_color_manual(
    values = c("red", "dodgerblue"), 
    labels = c("Female", "Male"),
    name = "Sex") +
  xlab("Year of observation") +
  ylab ("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom",
    aspect.ratio = 1,
    axis.text.x = element_text(angle=45, hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank())
ggsave(filename = "data/plottino_5.pdf", 
       plot = plottino_5,
       width = 10,
       height = 10)

#
