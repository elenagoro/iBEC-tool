
# Master R Script: Full Pipeline from Embryo Raw Data to Final Assessment
# ----------------------------------------------------------------------

library(readxl)
library(dplyr)
library(tidyr)

# -------------------------------
# 1. Load Embryo Raw Data
# -------------------------------
file_path <- "iBEC tool, v2.xlsx"
data_raw <- read_excel(file_path, sheet = "GoR Data_PE, PF", col_names = FALSE)

# Extract embryo-level raw data (Columns A–F, skipping header)
raw_measurements <- data_raw[2:1000, 1:6]  # Conservative row limit
colnames(raw_measurements) <- c("Basin", "Station", "Fecundity", "ViableEmbr_pct", "AbEmbr", "AberrGroup")

# Clean and convert
raw_measurements <- raw_measurements %>%
  filter(!is.na(Station) & !is.na(Fecundity)) %>%
  mutate(
    Fecundity = as.numeric(Fecundity),
    AbEmbr = as.numeric(AbEmbr)
  )

# Compute PE, PF, PE_n per station
summary_pe_pf <- raw_measurements %>%
  group_by(Station) %>%
  summarise(
    SumOfFecundity = sum(Fecundity, na.rm = TRUE),
    SumOfAbEmbr = sum(AbEmbr, na.rm = TRUE),
    PE = SumOfAbEmbr / SumOfFecundity,
    PF = sum(AbEmbr > 1, na.rm = TRUE) / n(),
    PE_n = n(),
    Species = "Monoporeia",
    .groups = "drop"
  )

# -------------------------------
# 2. Load Thresholds
# -------------------------------
thresholds <- read_excel(file_path, sheet = "TV") %>%
  rename(Marker = `Biomarker`) %>%
  mutate(Marker = make.names(Marker))
names(thresholds) <- make.names(names(thresholds))

# -------------------------------
# 3. Format as Biomarker Data
# -------------------------------
# Simulate structure similar to Raw Data Biomarker sheets
biomarker_data <- summary_pe_pf %>%
  pivot_longer(cols = c(PE, PF), names_to = "Marker", values_to = "Value") %>%
  mutate(
    Marker = make.names(Marker),
    Species = "Monoporeia"
  )

# Join with thresholds
biomarker_data <- biomarker_data %>%
  left_join(thresholds, by = "Marker") %>%
  mutate(
    above_GES = ifelse(!is.na(Threshold.value) & Value > Threshold.value, 1, 0),
    Exposure_or_Effect = ifelse(grepl("PE|PF", Marker), "Effect", "Exposure")  # Placeholder logic
  )

# -------------------------------
# 4. Summarize by Station
# -------------------------------
summary_station <- biomarker_data %>%
  group_by(Station, Exposure_or_Effect) %>%
  summarise(
    total_markers = n(),
    non_GES_markers = sum(above_GES, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  pivot_wider(
    names_from = Exposure_or_Effect,
    values_from = c(total_markers, non_GES_markers),
    names_sep = "_"
  )

# Total per station
summary_total <- biomarker_data %>%
  group_by(Station) %>%
  summarise(
    N_markers_used = n(),
    N_markers_non_GES = sum(above_GES, na.rm = TRUE),
    percent_non_GES = (N_markers_non_GES / N_markers_used) * 100,
    .groups = "drop"
  )

# Combine summaries
assessment_df <- summary_total %>%
  left_join(summary_station, by = "Station") %>%
  mutate(
    percent_exposure_exceeding_BAC = ifelse(total_markers_Exposure > 0,
      (non_GES_markers_Exposure / total_markers_Exposure) * 100, NA),
    percent_effect_exceeding_BAC = ifelse(total_markers_Effect > 0,
      (non_GES_markers_Effect / total_markers_Effect) * 100, NA),
    Assessment_result_per_station = ifelse(percent_non_GES <= 50, 1, 0)
  )

# -------------------------------
# 5. Basin-Level Summary
# -------------------------------
basin_summary <- assessment_df %>%
  summarise(
    Assessment_result_for_the_basin = mean(Assessment_result_per_station, na.rm = TRUE) * 100
  ) %>%
  mutate(
    YEAR = "2012-2022",
    Basin = "GoR"
  )

# -------------------------------
# 6. Final Output Format
# -------------------------------
final_output <- bind_rows(
  basin_summary %>%
    select(YEAR, Basin, Assessment_result_for_the_basin) %>%
    mutate(across(everything(), as.character)),
  assessment_df %>%
    mutate(
      YEAR = "2012-2022",
      Basin = "GoR"
    ) %>%
    select(
      YEAR, Basin, Assessment_result_per_station, N_markers_used,
      N_markers_non_GES, percent_non_GES,
      total_markers_Exposure, non_GES_markers_Exposure, percent_exposure_exceeding_BAC,
      total_markers_Effect, non_GES_markers_Effect, percent_effect_exceeding_BAC, Station
    )
)

# View result
print(head(final_output))
