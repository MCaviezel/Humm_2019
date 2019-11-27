## Import Data
set.seed(1234)
pacman::p_load(tidyverse, reshape2, plyr, xlsx)

setwd("~/Dropbox/Machine_Learning/R_stuff/Humm/2019")
df <- as_tibble(read.csv('Humm_2019.csv'))
df
#Gerichte
'Jakobsmuscheln'
'Butternut-Schnitzel mit schwarzem Pfeffer'
'Knoblauchsuppe mit Garnelen und Dicken Bohnen'
'Milchferkel-Racks mit Aprikosen'
'Himbeertarte'
'Birnenvariationen mit Honig und Ingwer'
'Erdbeeren mit Kamille'

variante_1 <- c('Jakobsmuscheln', 'Butternut-Schnitzel mit schwarzem Pfeffer', 'Milchferkel-Racks mit Aprikosen', 'Himbeertarte')
variante_2 <- c('Jakobsmuscheln', 'Butternut-Schnitzel mit schwarzem Pfeffer', 'Milchferkel-Racks mit Aprikosen', 'Erdbeeren mit Kamille')
variante_3 <- c('Jakobsmuscheln', 'Butternut-Schnitzel mit schwarzem Pfeffer', 'Milchferkel-Racks mit Aprikosen', 'Birnenvariationen mit Honig und Ingwer')

df_selected <- df %>% filter(Gericht %in% variante_1)

df_melt <- melt(df_selected, id = c('Gericht', 'Zutaten', 'Einheit'), measure.vars = "Menge.8.Personen")
df_melt

df_pivot <- dcast(df_melt, Gericht~Zutaten+Einheit, fun.aggregate = sum, margins=T)
df_pivot <- df_pivot %>% select(-ends_with('(all)'))
df_pivot_t <- as.data.frame(t(as.matrix(df_pivot)))
colnames(df_pivot_t) <- as.character(unlist(df_pivot_t[1,]))
variante_1_df_pivot_t <- df_pivot_t[-1 ,]
view(variante_1_df_pivot_t)

df_selected <- df %>% filter(Gericht %in% variante_2)

df_melt <- melt(df_selected, id = c('Gericht', 'Zutaten', 'Einheit'), measure.vars = "Menge.8.Personen")
df_melt

df_pivot <- dcast(df_melt, Gericht~Zutaten+Einheit, fun.aggregate = sum, margins=T)
df_pivot <- df_pivot %>% select(-ends_with('(all)'))
df_pivot_t <- as.data.frame(t(as.matrix(df_pivot)))
colnames(df_pivot_t) <- as.character(unlist(df_pivot_t[1,]))
variante_2_df_pivot_t <- df_pivot_t[-1 ,]
view(variante_2_df_pivot_t)

df_selected <- df %>% filter(Gericht %in% variante_3)

df_melt <- melt(df_selected, id = c('Gericht', 'Zutaten', 'Einheit'), measure.vars = "Menge.8.Personen")
df_melt

df_pivot <- dcast(df_melt, Gericht~Zutaten+Einheit, fun.aggregate = sum, margins=T)
df_pivot <- df_pivot %>% select(-ends_with('(all)'))
df_pivot_t <- as.data.frame(t(as.matrix(df_pivot)))
colnames(df_pivot_t) <- as.character(unlist(df_pivot_t[1,]))
variante_3_df_pivot_t <- df_pivot_t[-1 ,]
view(variante_3_df_pivot_t)

write.xlsx(variante_1_df_pivot_t, file="Einkaufsliste_Humm_2019.xlsx", sheetName="Variante_1", row.names=T)
write.xlsx(variante_2_df_pivot_t, file="Einkaufsliste_Humm_2019.xlsx", sheetName="Variante_2", row.names=T, append = T)
write.xlsx(variante_3_df_pivot_t, file="Einkaufsliste_Humm_2019.xlsx", sheetName="Variante_3", row.names=T, append = T)



