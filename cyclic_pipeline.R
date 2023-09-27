library(ggplot2)
library(tidyr)
library(dplyr)
library(ggcorrplot)


# Daten aus der .txt-Datei einlesen
data <- read.table("cyclictest.txt", header = FALSE)
# Manuell Spaltennamen festlegen
colnames(data) <- c("Core", "Index", "Latenz")
# pipe
test <- data %>% select("Core", "Index", "Latenz")  %>%  na.omit() %>%  sample_n(100000)  %>% group_by(Core, Latenz) %>% summarize(count = n(), mean_latency=mean(Latenz))  %>% ggplot(aes(x = Core, y = Latenz, color = factor(Core))) + geom_point(aes(size = count)) + labs(title = "Latenzen in Echtzeitsystemen", x = "Core", y = "Latenz")
print(test)
## sampling
stichprobengroesse <- 5000000
extremwerte <- data %>% filter(Latenz < quantile(Latenz, 0.99999))
print(extremwerte)
stichprobe <- extremwerte %>% sample_n(stichprobengroesse)
print(stichprobe)

final_sampled_data <- rbind(stichprobe, extremwerte)

# Größter Wert in der Spalte "Latenz" ausgeben
max_latenz <- max(data$Latenz)
min_latenz <- min(data$Latenz)
print("Größter Wert in der Spalte 'Latenz':")
print(max_latenz)
print(min_latenz)

# test
cleaned <- final_sampled_data %>% group_by(Core, Latenz) %>% summarize(count = n())
print(dim(cleaned))
print(cleaned)

# Zeilen mit doppelten Core- und Latenzwerten entfernen da der Datensatz zu groß ist
data_unique <- data[!duplicated(data[, c("Core", "Latenz")]), ]
print(dim(data_unique))
print(data_unique)

# Durchschnittliche Latenz pro Core berechnen
average_latency <- aggregate(Latenz ~ Core, data = data, FUN = mean)
print(average_latency)
print(data_unique)

# data to ink maximieren
# Scatterplot mit farblicher Kennzeichnung und Regressionslinien erstellen
ggplot(average_latency, aes(x = Core, y = Latenz)) +
  geom_line() +
  labs(title = "Durchschnittliche Latenz pro Core", x = "Core", y = "Latenz [us]") +
  theme_minimal()



# done scatter with average
ggplot(cleaned, aes(x = Core, y = Latenz, color = factor(Core))) +
  geom_point(aes(size = count)) +  # Größe der Punkte basierend auf count
  geom_line(data = average_latency, aes(x = Core, y = Latenz, linetype = "Durchschnittliche Latenz pro Core"), 
            color = "black", size = 0.75) +
  geom_text(data = average_latency %>% filter(Latenz == max(Latenz)),
            aes(x = Core, y = Latenz, label = " "), 
            vjust = -0.5, hjust = 1, color = "black") +  # Beschriftung am Ende der Linie
  coord_cartesian(ylim = c(0, 150)) +
  labs(title = "Latenzen in Echtzeitsystemen", x = "Core", y = "Latenz") +
  theme_gray() +
  scale_linetype_manual(name = "Linientyp", values = c("Durchschnittliche Latenz pro Core" = "solid")) +
  guides(color = guide_legend(override.aes = list(size = 3)))  # Legendenanpassung


# boxplot
ggplot(cleaned, aes(x = Core, y = Latenz, color = factor(Core))) +
  #geom_point(aes(size = count)) +  # Größe der Punkte basierend auf count
  geom_boxplot() +
  coord_cartesian(ylim = c(0, 300)) +
  labs(title = "Latenzen in Echtzeitsystemen", x = "Core", y = "Latenz") +
  theme_gray()

print(dim(cleaned))


## Prozent unter 150 Berechnen
# Gesamtanzahl der Datenpunkte
total_data_points <- nrow(data)
# Anzahl der Datenpunkte mit Latenz unter 150
latency_under_150_count <- sum(data$Latenz < 150)
# Prozentsatz der Datenpunkte mit Latenz unter 150
percentage_under_150 <- (latency_under_150_count / total_data_points) * 100
# Ausgabe des Prozentsatzes
print("Prozentsatz der Datenpunkte mit Latenz unter 150:")
print(percentage_under_150)
print(total_data_points-latency_under_150_count)
print()

