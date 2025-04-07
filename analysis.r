# Load necessary libraries
library(dplyr)
library(tidyr)
library(readr)

# Read the CSV file
df <- read_csv("/Users/lucaschoi/Documents/GitHub/ECE286-Distraction-Project/data.csv")

# Separate baseline and distracted entries
baseline <- df %>% 
  filter(Distraction == "None") %>% 
  select(Participant, `Reading Time (seconds)`, `Reading speed (WPM)`) %>%
  rename(`Baseline Reading Time (seconds)` = `Reading Time (seconds)`,
         `Baseline Reading speed (WPM)` = `Reading speed (WPM)`)

distracted <- df %>%
  filter(Distraction != "None") %>%
  rename(`Distracted Reading Time (seconds)` = `Reading Time (seconds)`,
         `Distracted Reading Speed (WPM)` = `Reading speed (WPM)`)

# Join baseline and distracted data
final_df <- distracted %>%
  left_join(baseline, by = "Participant") %>%
  mutate(`Normalized Reading speed` = `Distracted Reading Speed (WPM)` / `Baseline Reading speed (WPM)`) %>%
  select(Participant, Major, Year, `Years speaking English`, `Other languages`, Distraction,
         `Baseline Reading Time (seconds)`, `Distracted Reading Time (seconds)`,
         `Errors Missed`, `Errors Incorrectly Identified`, `Errors Identified`,
         `Error Rate (identified / total)`, `Baseline Reading speed (WPM)`,
         `Distracted Reading Speed (WPM)`, `Normalized Reading speed`)
options(tibble.width = Inf)
print(final_df, n = Inf)



