# iBEC-tool
a workflow for integrating biological effect indicators/biomarkers for Descriptor 8 (Criterion 8.2), MSFD

---

## Overview

The **iBEC-tool** is a systematic and reproducible workflow for assessing biological effects of contaminants in marine environments.  
It integrates suborganismal (biochemical, cellular, molecular) and organismal (reproductive, growth, condition) responses to provide a holistic evaluation of environmental stress from contaminant exposure.

Originally developed within the **BEACON Project** for the Baltic Sea, iBEC is applicable to other marine regions and supports regulatory compliance, scientific research, and regional monitoring programs.

---

## Features

- **Multi-level biological effect integration**: biomarkers and organism health indices.
- **Automated calculations**: built-in Excel functions for BAC/EAC comparison.
- **Multi-species support**: works with fish, benthic invertebrates, and bivalves.
- **MSFD Descriptor 8.2 compliance**: aligns with OSPAR/JAMP assessment principles.
- **Case studies included**: Bothnian Sea & Gulf of Riga datasets.

---

## Structure

The main workbook `iBEC-tool.xlsx` contains interconnected spreadsheets:

- **Assessment Units** – HELCOM Assessment Units (fixed data)
- **Stations** – sampling site metadata
- **Species** – list of assessed species
- **Sex** – sex-specific entries (for sex-dependent biomarkers)
- **Tissues** – tissue type information
- **BE Rationale** – list of biological effect parameters, rationale, and units
- **TV** – target values (BAC/EAC) for exposure and effect biomarkers
- **Data Summary** – aggregated BE parameter data per station
- **BAC Exceedance** – binary exceedance of BAC/EAC (0=sub-GES, 1=in-GES)
- **Assessment** – integrated subbasin and station-level outputs
- **Visualization** – diagrams summarising assessment results

Color coding:
- **Grey** – manual entry
- **Green** – auto-copied data
- **Blue** – auto-calculated
- **Yellow/Purple** – review if necessary

---

## Data Requirements

- Minimum 5 observations per BE parameter for BAC/EAC derivation.
- At least 2 exposure and 2 effect markers per basin.
- At least 3 years of observations for MSFD 6-year cycle assessments.

---

## Workflow Steps

1. Add stations and geographic metadata.
2. Select target species, tissues, and sex (if applicable).
3. Confirm and adjust BE parameter list.
4. Define BAC/EAC target values (from reference sites).
5. Prepare and import primary data.
6. Use the Standardised Automated Spreadsheet (optional) for BAC/EAC evaluation.
7. Populate BAC Exceedance sheet with results.
8. Aggregate results at subbasin level.
9. Generate visual outputs.
10. Interpret results for D8.2 assessment.

---

## Applications

- **Regulatory**: MSFD Descriptor 8.2 assessments.
- **Research**: linking contaminants to biological effects in field and lab studies.
- **Monitoring**: integration into national and regional environmental monitoring.

---

## Case Studies

The repository includes example datasets from:
- **Bothnian Sea** – sediment, amphipods (*Monoporeia affinis*), and perch (*Perca fluviatilis*).
- **Gulf of Riga** – amphipods, clams (*Macoma balthica*), fish (herring, perch, goby).

---

## Requirements

- **Excel 2019 or later** (or Office 365).
- Enable macros if prompted.
- Optional: R or Python for advanced data analysis.

---

## License

This project is licensed under the **CC-BY** – see [LICENSE](LICENSE) for details.

---

## Citation

If you use the iBEC-tool in your work, please cite:

> Gorokhova, E., Alurralde, G., Kolesova, N., Kuprijanov, I., Barda, I., Strode, E. (2024).  
> *Integrated workflow for assessing biological effects of contaminants in the Baltic Sea*. BEACON Project Deliverable 1.3.

---

## Contact

Maintainer: **Elena Gorokhova**  
Stockholm University  
Email: [elena.gorokhova@su.se](mailto:elena.gorokhova@su.se)
