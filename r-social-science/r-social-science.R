# CREATE PROJECT ------------------------------------------------------------------------------------------------------

# CREATE FOLDERS ------------------------------------------------------------------------------------------------------

dir.create("data")
dir.create("data_output")
dir.create("documents")
dir.create("fig_output")
dir.create("scripts")

# DOWNLOAD DATA -------------------------------------------------------------------------------------------------------

download.file(
  "https://ndownloader.figshare.com/files/11492171",
  "data/SAFI_clean.csv",
  mode = "wb"
)

# INSTALL TIDYVERSE ---------------------------------------------------------------------------------------------------

install.packages("tidyverse")

# FANCY CALCULATOR ----------------------------------------------------------------------------------------------------

3 + 5
12 / 7

# CREATING VARIABLES --------------------------------------------------------------------------------------------------

area_hectares = 1.0
area_hectares <- 1.0

area_hectares <- 7 * 5
# Now echo the value.
(area_hectares <- 7 * 5)

area_hectares * 2.47
(area_acres <- area_hectares * 2.47)

area_hectares <- 10

# Has this has changed area in acres.
area_acres

# COMMENTS ------------------------------------------------------------------------------------------------------------

length = 50                            # Property length (metre)
width = 30                             # Property width (metre)
(area = length * width)                # Property area

# Change length and width
length = 45
width = 35

# Is there an effect on area?
area

# FUNCTIONS LIKE ROUND ------------------------------------------------------------------------------------------------

ceiling(3.14159)
floor(3.14159)

ceiling(-3.5)
floor(-3.5)

# Truncate "towards zero"
trunc(3.5)
trunc(-3.5)

# Set the number of decimal places
round(12.3456789, 4)
# Set the number of significant digits
signif(12.3456789, 4)

# CREATING VECTORS ----------------------------------------------------------------------------------------------------

# Number of household members
(hh_members <- c(3, 7, 10, 6))

# Material used for construction.
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")

length(hh_members)

class(hh_members)
class(respondent_wall_type)

possessions <- c("bicycle", "radio", "television")
possessions <- c(possessions, "mobile_phone")      # Add to the end of the vector
possessions <- c("car", possessions)               # Add to the beginning of the vector
possessions

# MIXING TYPES IN VECTORS ---------------------------------------------------------------------------------------------

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

# COMBINING VECTORS ---------------------------------------------------------------------------------------------------

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

# How many values in combined_logical are "TRUE"?
combined_logical
sum(combined_logical == "TRUE")

# SLICING VECTORS (BY INDEX) -----------------------------------------------------------------------------------------

hh_members
# Only the second element
hh_members[2]
# The first and third elements
hh_members[c(1, 3)]
# The first through third elements
hh_members[1:3]
# Everything but the fourth element
hh_members[-4]

# SLICING VECTORS (BY MASK) -------------------------------------------------------------------------------------------

hh_members
# The first and third elements
hh_members[c(TRUE, FALSE, TRUE, FALSE)]
# All elements with value greater than 6
hh_members[hh_members > 6]
# All elements with value greater than 6 AND less than 10
hh_members[hh_members > 6 & hh_members < 10]
# All elements with value greater than 6 OR less than 4
hh_members[hh_members > 6 | hh_members < 4]

# MISSING DATA --------------------------------------------------------------------------------------------------------

rooms <- c(2, 1, 1, NA, 4)

mean(rooms)
mean(rooms, na.rm = TRUE)

rooms[!is.na(rooms)]
na.omit(rooms)

rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)
# New vector with NA values removed
rooms[!is.na(rooms)]
na.omit(rooms)
# Medium number of rooms
median(rooms)
median(rooms, na.rm = TRUE)
# Number of households with more than 2 rooms
sum(na.omit(rooms) > 2)

# LOADING DATA --------------------------------------------------------------------------------------------------------

library(tidyverse)

interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
#
# key_id	             - unique ID for each observation
# village	             - Village name
# interview_date       - Date of interview
# no_membrs            - How many members in the household?
# years_liv	           - How many years have you been living in this village or neighboring village?
# respondent_wall_type - What type of walls does their house have (from list)
# rooms                - How many rooms in the main house are used for sleeping?
# memb_assoc           - Are you a member of an irrigation association?
# affect_conflicts     - Have you been affected by conflicts with other irrigators in the area?
# liv_count            - Number of livestock owned.
# items_owned          - Which of the following items are owned by the household? (list)
# no_meals             - How many meals do people in your household normally eat in a day?
# months_lack_food     - Which months (in the last 12 months) did not have enough food to feed the household?
# instanceID           - Unique identifier for the form data submissio

# GAWKING AT THE DATA -------------------------------------------------------------------------------------------------

class(interviews)

interviews

head(interviews)
tail(interviews)

View(interviews)

dim(interviews)
nrow(interviews)
ncol(interviews)

names(interviews)

# SLICING -------------------------------------------------------------------------------------------------------------

interviews[1, ]
interviews[, 1]

interviews[, "key_ID"]
interviews$key_ID

interviews[3:5, 2]
interviews[3:5, "village"]

interviews_100 <- interviews[1:100,]
interviews_100 <- head(interviews, n = 100)

# Just the last row
interviews[nrow(interviews),]
# Using tail
tail(interviews, n = 1)

interviews_last <- interviews[nrow(interviews),]

interviews_middle <- interviews[round(nrow(interviews) / 2), ]

# FACTORS -------------------------------------------------------------------------------------------------------------

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))

levels(respondent_floor_type)

nlevels(respondent_floor_type)

# What's happening behind the scenes?
as.integer(respondent_floor_type)

# Change order of levels
(respondent_floor_type <- factor(respondent_floor_type, levels = c("earth", "cement")))
# The first level is often a "reference" level in models.

# Converting factors to strings
as.character(respondent_floor_type)
# Converting factors to numbers
year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)                        # Doesn't work!
as.numeric(as.character(year_fct))

memb_assoc <- as.factor(interviews$memb_assoc)
memb_assoc
table(memb_assoc)

memb_assoc <- interviews$memb_assoc
memb_assoc[is.na(memb_assoc)] <- "???"
(memb_assoc <- as.factor(memb_assoc))
table(memb_assoc)

memb_assoc <- interviews$memb_assoc
memb_assoc[is.na(memb_assoc)] <- "???"
# - Rename the levels of the factor to have the first letter in uppercase.
# - Change the order of the levels so that ??? is last.
factor(memb_assoc, levels = c("no", "yes", "???"), labels = c("No", "Yes", "???"))

# What about encoding gender?

# DATES ---------------------------------------------------------------------------------------------------------------

dates <- interviews$interview_date
head(dates)
class(dates)
# Are there other date/time types in R?

library(lubridate)

interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)

interviews[, c("interview_date", "year", "month", "day")]

# TIDYVERSE -----------------------------------------------------------------------------------------------------------

library(tidyverse)

library(dplyr)
library(tidyr)

# SELECTING COLUMNS ---------------------------------------------------------------------------------------------------

select(interviews, village, no_membrs, years_liv)

# FILTERING ROWS ------------------------------------------------------------------------------------------------------

filter(interviews, village == "God")

# PIPE ----------------------------------------------------------------------------------------------------------------

interviews2 <- filter(interviews, village == "God")
interviews_god <- select(interviews2, no_membrs, years_liv)

interviews_god <- select(filter(interviews, village == "God"), no_membrs, years_liv)

interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews %>% filter(memb_assoc == "yes") %>% select(affect_conflicts, liv_count, no_meals)

# MUTATE --------------------------------------------------------------------------------------------------------------

interviews %>%
  mutate(people_per_room = no_membrs / rooms)

# Does being a member of an irrigation association has an effect on the ratio of household members to rooms?
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs / rooms)

interviews %>%
  mutate(
    total_meals = no_membrs * no_meals
  ) %>%
  filter(total_meals < 20) %>%
  select(village)

# SUMMARIES -----------------------------------------------------------------------------------------------------------

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(
    mean_no_membrs = mean(no_membrs),
    min_membrs = min(no_membrs)
  )

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), min_membrs = min(no_membrs)) %>%
  arrange(min_membrs)

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), min_membrs = min(no_membrs)) %>%
  arrange(desc(min_membrs))

interviews %>%
  count(village)

interviews %>%
  count(village, sort = TRUE)

# Count of average number of meals per day.
interviews %>%
  count(no_meals)

interviews %>%
  group_by(village) %>%
  summarise(
    mean_no_membrs = mean(no_membrs),
    min_no_membrs = min(no_membrs),
    max_no_membrs = max(no_membrs),
    observations = n()
  )

# Largest household interviewed in each month?
interviews %>%
  group_by(month) %>%
  summarise(
    largest_household = max(no_membrs)
  )

# SPREAD --------------------------------------------------------------------------------------------------------------

interviews %>%
  select(instanceID, respondent_wall_type, no_membrs)

interviews_spread <- interviews %>%
  select(instanceID, respondent_wall_type, no_membrs) %>%
  spread(respondent_wall_type, no_membrs)
interviews_spread

interviews %>%
  select(instanceID, respondent_wall_type, no_membrs) %>%
  spread(respondent_wall_type, no_membrs, fill = 0)

# GATHER --------------------------------------------------------------------------------------------------------------

interviews_spread %>%
  gather(respondent_wall_type, no_membrs, burntbricks, cement, muddaub, sunbricks)
# A shortcut way to specify range of columns.
interviews_spread %>%
  gather(respondent_wall_type, no_membrs, burntbricks:sunbricks)

interviews_spread %>%
  gather(respondent_wall_type, no_membrs, -instanceID)

# CLEANING ------------------------------------------------------------------------------------------------------------

interviews %>%
  select(key_ID, items_owned)

interviews %>%
  separate_rows(items_owned, sep=";") %>%
  select(key_ID, items_owned)

interviews %>%
  separate_rows(items_owned, sep=";") %>%
  mutate(items_owned_logical = TRUE) %>%
  select(key_ID, items_owned, items_owned_logical)

interviews %>%
  separate_rows(items_owned, sep=";") %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = items_owned, value = items_owned_logical, fill = FALSE)

# Months without food.
interviews_months_lack_food <- interviews %>%
  separate_rows(months_lack_food, sep=";") %>%
  mutate(months_lack_food_logical  = TRUE) %>%
  spread(key = months_lack_food, value = months_lack_food_logical, fill = FALSE)

# Average months without food versus irrigation association.
interviews_months_lack_food <- interviews %>%
  separate_rows(months_lack_food, sep=";") %>%
  group_by(memb_assoc, key_ID) %>%
  summarise(
  count = n()
  ) %>%
  summarise(
  mean_months = mean(count)
  )

# EXPORTING -----------------------------------------------------------------------------------------------------------

interviews_plotting <- interviews %>%
  ## spread data by items_owned
  separate_rows(items_owned, sep=";") %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = items_owned, value = items_owned_logical, fill = FALSE) %>%
  rename(no_listed_items = `<NA>`) %>%
  ## spread data by months_lack_food
  separate_rows(months_lack_food, sep=";") %>%
  mutate(months_lack_food_logical = TRUE) %>%
  spread(key = months_lack_food, value = months_lack_food_logical, fill = FALSE) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
  mutate(number_items = rowSums(select(., bicycle:television)))

write_csv(interviews_plotting, path = "data_output/interviews_plotting.csv")

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
