## this file appends newly updated data to the master file

library(tidyverse)
library(magrittr)


#read in and preview data files

new <- read.csv("data/oda_ceeb_update_john_dooris_2023-10-18.csv",stringsAsFactors = F)
head(new,n = 100)

df <- read.csv("oda_nces_ceeb_crosswalk.csv",stringsAsFactors = F)
head(df)

table(nchar(new$HS_CEEB))

#convert ceebs codes to characters to minimize risk of dropped zeros.

new$HS_CEEB %<>% as.character(.)

df.agg <- new %>%
  mutate(HS_CEEB_NEW = case_when(
    nchar(HS_CEEB) < 6 ~ str_pad(HS_CEEB, width = 6, side = "left", pad = "0"),
    TRUE ~ HS_CEEB
  ))


# a few gut checks on the length of variables. HS CEEB should be six. Postal codes should be 5

head(df.agg)
table(nchar(df.agg$HS_CEEB_NEW))
table(nchar(df.agg$HS_POSTAL_CD))


# select variables to match earlier file format

upsert <- df.agg %>%
  select(HS_CEEB = HS_CEEB_NEW,
         HS_NCES,
         HS_CITY,
         MATCH_NAME = HS_NAME, # since we don't have new data on the NCES side, these are just set to equal for upserts
         HS_POSTAL_CD,
         HS_STATE) %>%
  mutate(HS_NAME = MATCH_NAME,
         MATCH_SCORE = NA, #this match score is set to NA since upserts are using trust rather than Turk
         MATCH_SOURCE = max(df$MATCH_SOURCE,na.rm = T) + 1 ) %>%
  as.data.frame(.)

head(upsert)  


## check for dupes WITHIN the new file         

upsert <- upsert %>%
  mutate(HS_DUPED = duplicated(HS_CEEB)) %>%
  as.data.frame(.)

table(upsert$HS_DUPED)         


#check for name matching

# Reorder df1 to match the order of names in df2

upsert <- upsert %>%
  select(names(df)) %>%
  as.data.frame(.)

str(df)
str(upsert)

df$HS_CEEB %<>% as.character(.)
upsert$HS_POSTAL_CD %<>% as.character(.)
upsert$HS_DUPED %<>% as.character(.)  

# bind them together

df <- bind_rows(df,upsert)

head(df)

# gut checks

table(df$MATCH_SOURCE)

#final depdupe

df <- df %>%
  mutate(HS_DUPED = duplicated(HS_CEEB)) %>%
  as.data.frame(.)

table(df$HS_DUPED)

# check dupes

dupes <- filter(df,HS_DUPED == TRUE) %>%
  as.data.frame(.)

# full list

df.dupes <- df %>%
  filter(HS_CEEB %in% dupes$HS_CEEB) %>%
  arrange(HS_NCES) %>%
  as.data.frame(.)

# select which to keep

keep <- c(1,6,8,10)

df.dupes <- df.dupes[keep,]

# remove duped rows from master data frame and recheck for dupes

df <- df %>%
  filter(!HS_CEEB %in% df.dupes$HS_CEEB) %>%
  bind_rows(.,df.dupes) %>%
  mutate(HS_DUPED = duplicated(HS_CEEB)) %>%
  as.data.frame(.)


# write out new file

write.csv(df, "oda_nces_ceeb_crosswalk.csv",row.names = F)

table(df$HS_DUPED,useNA = "always")


