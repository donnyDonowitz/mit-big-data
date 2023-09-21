library(ggplot2)
library(tidyr)
library(dplyr) 
library(ggcorrplot)


# Einlesen des Datensatzes aus der Datei
data <- read.table("seuh20.txt", header = TRUE, sep = "\t", skip=2)
colnames(data)

# Manuell Spaltennamen festlegen wegen formatting
colnames(data) <- c("Question", "Type", "Analysis", "TimeResolved", "Predict")

# Den Datensatz anzeigen
print(data)
# anzahl spalten
ncol(data)
# anzahl spalten
nrow(data)


# aggregate same research topics and acc count
library(dplyr)
dat <- data %>% select(Type, Analysis, TimeResolved, "Predict") %>% group_by_all() %>% count
print(dat)
# dat$Type <- dat[dat$Type == "M", "Type"] = "Multi"
# dat$Type <- dat[dat$Type == "S", "Type"] = "Single"
print(dat)

# Gestapeltes Balkendiagramm erstellen
ggplot(dat, aes(x = Analysis, y = n, fill = paste(Type, TimeResolved, Predict, sep = "-"))) +
  geom_bar(stat = "identity", position = "stack") + #dodge
  labs(title = "Uebersicht der Forschungs-Fragestellungen", x = "Forschungsfragestellungen", y = "Anzahl") +
  theme_minimal()
  scale_fill_discrete(name = "Kombinationen", labels = c("M-N-N", "M-N-Y", "M-Y-N", "R-N-N", "R-N-Y", "R-Y-Y", "S-N-N", "S-Y-N"))

  
# wohooo der shit hier
  
# Gestapeltes Balkendiagramm erstellen
ggplot(dat, aes(x = Analysis, y = n, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_discrete(labels = c("Hypo", "Measure", "Relation")) +
  scale_y_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10)) + 
  facet_wrap(facets= vars(TimeResolved, Predict), labeller=label_both) +
  scale_fill_discrete(name = "Type", labels = c("Multi", "Single")) +
  labs(title = "Uebersicht der Forschungs-Fragestellungen", x = "Forschungsfragestellungen", y = "Anzahl") +
  theme_bw()
  
  
# aggregate same research topics and acc count
colnames(data)
dat2 <- data %>% select(Type, Analysis, TimeResolved, Predict) %>% group_by(Analysis) %>% summarise(
  ThesisCount = n(),
  Single_Count = sum(Type == "S"),
  Multi_Count = sum(Type == "M"),
  Time_Resolved_Y_Count = sum(TimeResolved == "Y"),
  Time_Resolved_N_Count = sum(TimeResolved == "N"),
  Predict_Y_Count = sum(Predict == "Y"),
  Predict_N_Count = sum(Predict == "N")
)
print(dat2)

stacked_data <- dat2 %>%
  pivot_longer(cols = -Analysis & -ThesisCount, names_to = "Category", values_to = "Count")  %>%
  filter(Count>0)
print(stacked_data)

stacked_data %>%
  ggplot(aes(x = Analysis, y = Count, fill=Category)) +
  geom_col(position = "stack", color = "white") +
  # scale_y_continuous(labels = scales::percent) +
  labs(title = "Uebersicht der Forschungs-Fragestellungen")




dat %>%
  count(Type, Analysis) %>%
  group_by(Analysis) %>%
  mutate(prop = round(n/sum(n), 4)) %>%
  ggplot(aes(x = Analysis, y = prop)) +
  geom_col(position = "stack", color = "white") +
  # scale_y_continuous(labels = scales::percent) +
  scale_fill_distiller(palette = "Blues") +
  labs(title = "Uebersicht der Forschungs-Fragestellungen")

