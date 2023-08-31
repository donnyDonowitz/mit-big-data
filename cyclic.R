library(ggplot2)
library(tidyr)
library(dplyr)
library(ggcorrplot)


# Daten aus der .txt-Datei einlesen
data <- read.table("cyclictest.txt", header = FALSE)
# print(dim(data))
# Manuell Spaltennamen festlegen
colnames(data) <- c("Core", "Index", "Latenz")

# Zeilen mit doppelten Core- und Latenzwerten entfernen da der Datensatz zu groß ist
data_unique <- data[!duplicated(data[, c("Core", "Latenz")]), ]
print(dim(data_unique))

sampled_data <- data[sample(nrow(data), size = nrow(data) * 0.0002), ]

# Streudiagramm erstellen
ggplot(data_unique, aes(x = Index, y = Latenz, color = factor(Core))) + 
  geom_point() +
  labs(title = "Latenz nach Core und Index", x = "Index", y = "Latenz")

# Streudiagramm mit Facet Grid erstellen
ggplot(data_unique, aes(x = Index, y = Latenz, color = factor(Core))) +
  geom_point() +
  facet_wrap(~Core, ncol = 2) +
  labs(title = "Latenz nach Core und Index", x = "Index", y = "Latenz")

# Interaction Plot erstellen
ggplot(data_unique, aes(x = Index, y = Latenz, color = factor(Core))) +
  geom_point(position = position_dodge(width = 0.2)) +
  labs(title = "Latenz nach Core und Index", x = "Index", y = "Latenz")

# Durchschnittliche Latenz pro Core berechnen
average_latency <- aggregate(Latenz ~ Core, data = data, FUN = mean)

# SELECTED!!!!
# Scatterplot mit farblicher Kennzeichnung und Regressionslinien erstellen
ggplot(average_latency, aes(x = Core, y = Latenz, color = factor(Core))) +
  geom_point() +
  geom_smooth() + # Regressionslinien hinzufügen
  labs(title = "Durchschnittliche Latenz pro Core", x = "Core", y = "Latenz")

# ggsave("./plot.pdf", ggp)




## correlaction testing
## Durschschnittliche Verspätung pro Monat

data %>% select(Core, Latenz) %>% na.omit() %>% group_by(Core) %>% summarize(latency=mean(Latenz))

## Durschschnittliche Verspätung pro Monat, berückscihtigung der Abflugsverspätung

flights %>% select(arr_delay, dep_delay, month) %>% na.omit() %>% group_by(month) %>% summarize(depmean=mean(dep_delay), arrmean=mean(arr_delay))

## correlation dazwischen

cor(data %>% select(Core, Latenz) %>% na.omit() %>% group_by(Core) %>% summarize(latency=mean(Latenz)))

## und plotten

ggcorrplot(cor(data %>% select(Core, Latenz) %>% na.omit() %>% group_by(Core) %>% summarize(latency=mean(Latenz))))

















































# Interaction Plot erstellen
ggplot(data_unique, aes(x = Index, y = Latenz, color = factor(Core))) +
  geom_point(position = position_dodge(width = 0.2)) +
  labs(title = "Latenz nach Core und Index", x = "Index", y = "Latenz")
