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
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/pricespread/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/pricespread/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/pricespread/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/pricespread/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/axfinder/latencies.txt",
  "db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/pricespread/latencies.txt"
)

data <- data.frame()

# Schleife zum Einlesen der Datensätze
for (i in path_to_datasets) {
  
  # Lese den Datensatz ein
  dat <- read.table(i, header = FALSE)
  colnames(dat) <- c("ID", "Timestamp", "ProcessingTime")
  dat$Dataset <- i
  # Füge den eingelesenen Datensatz dem großen Datensatz hinzu
  data <- rbind(data, dat)
  cat("Datensatz", i, "eingelsen.\n")
}
print(data)
