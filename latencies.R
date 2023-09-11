library(ggplot2)
library(tidyr)
library(dplyr) 
library(ggcorrplot)


# Spalte 1: Anfragenummer
# Spalte 2: Zeit der Anfrage [ns], nullbasiert
# Spalte 3: Verarbeitungszeit [ns]

# arm_clock datasets
axfinder <- read.table("db_responses/arm_clock/default/axfinder/latencies.txt", header = FALSE)
countone <- read.table("db_responses/arm_clock/default/countone/latencies.txt", header = FALSE)
pricespread <- read.table("db_responses/arm_clock/default/pricespread/latencies.txt", header = FALSE)

# x86_clock

## 1: default calibrate
axfinder_1 <- read.table("db_responses/x86_clock/res_duration-20_stress-0_scenario-default_calibrate/axfinder/latencies.txt", header = FALSE)
pricespread_1 <- read.table("db_responses/x86_clock/res_duration-20_stress-0_scenario-default_calibrate/pricespread/latencies.txt", header = FALSE)


## 2. default measure
axfinder_2 <- read.table("db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/axfinder/latencies.txt", header = FALSE)
countone_2 <- read.table("db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/axfinder/latencies.txt", header = FALSE)
pricespread_2 <- read.table("db_responses/x86_clock/res_duration-20_stress-0_scenario-default_measure/pricespread/latencies.txt", header = FALSE)

## 3. default measure
axfinder_3 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/axfinder/latencies.txt", header = FALSE)
countone_3 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/axfinder/latencies.txt", header = FALSE)
pricespread_3 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-default_measure/pricespread/latencies.txt", header = FALSE)

## 4. fifo measure
axfinder_4 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/axfinder/latencies.txt", header = FALSE)
countone_4 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/axfinder/latencies.txt", header = FALSE)
pricespread_4 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-fifo_measure/pricespread/latencies.txt", header = FALSE)

## 5. shield measure
axfinder_5 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/axfinder/latencies.txt", header = FALSE)
countone_5 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/axfinder/latencies.txt", header = FALSE)
pricespread_5 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield_measure/pricespread/latencies.txt", header = FALSE)

## 6. shield + fifo measure
axfinder_6 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/axfinder/latencies.txt", header = FALSE)
countone_6 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/axfinder/latencies.txt", header = FALSE)
pricespread_6 <- read.table("db_responses/x86_clock/res_duration-20_stress-1_scenario-shield+fifo_measure/pricespread/latencies.txt", header = FALSE)
