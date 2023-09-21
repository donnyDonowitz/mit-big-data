library(ggplot2)
library(tidyr)
library(dplyr) 
library(ggcorrplot)

# Pfade zu allen Datensätzen
path_to_datasets = c(
  "db_responses/arm_clock/default/axfinder/latencies.txt",
  "db_responses/arm_clock/default/countone/latencies.txt",
  "db_responses/arm_clock/default/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_calibrate/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_calibrate/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/countone/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/countone/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/countone/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/countone/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/pricespread/latencies.txt",
  
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/countone/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/pricespread/latencies.txt"
)

data <- data.frame()
stichprobengroesse <- 10000

# Schleife zum Einlesen der Datensätze
for (i in path_to_datasets) {
  
  # Lese den Datensatz ein
  dat <- read.table(i, header = FALSE)
  # Labeln und Beschriften
  colnames(dat) <- c("ID", "Timestamp", "ProcessingTime")
  dat$Dataset <- i
  if (grepl("arm_clock", i, fixed = TRUE)) {
    dat$Architecture <-"ARM"
  } else {
    dat$Architecture <- "x86"
  }
  if (grepl("axfinder", i, fixed = TRUE)) {
    cat("axfinder\n")
    dat$Category <-"axfinder"
  } else if ( grepl("pricespread", i, fixed = TRUE)) {
    cat("pricespread\n")
    dat$Category <-"pricespread"
  } else {
    cat("countone\n")
    dat$Category <-"countone"
  }
  
  # sampling ohne Verlust der Extremwerte
  extremwerte <- dat %>% filter(ProcessingTime > quantile(ProcessingTime, 0.950))
  stichprobe <- dat %>% anti_join(extremwerte, by = "ID") %>% sample_n(stichprobengroesse, replace = TRUE)
  
  # zusammenfuegen
  
  data <- rbind(data, stichprobe)
  cat("Datensatz", i, "eingelsen.\n")
}
print(data)

# Scatterplot mit farblicher Kennzeichnung und Regressionslinien erstellen
ggplot(data, aes(x = Timestamp, y = ProcessingTime, color = Category)) +
  geom_boxplot() +
  # geom_point() +
  # geom_line() +
  facet_wrap(~Architecture, scales = "free_x") +
  # geom_smooth() + # Regressionslinien hinzufügen
  scale_x_continuous(labels = scales::comma) +  # Formatierung der x-Achsenbeschriftung
  scale_y_continuous(labels = scales::comma) +  # Formatierung der y-Achsenbeschriftung
  labs(title = "Verarbeitungszeiten für Finanzstromqueries in Echtzeitdatenbanken", x = "Zeit der Anfrage [ns]", y = "Verarbeitungszeit [ns]") +
  theme_bw()
