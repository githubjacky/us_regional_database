# data set: 'Regional'
# possible parameters:
# 1. 'GeoFips': string,
#                GeoFips specifies geography, It can be all states (STATE),
#                all counties (COUNTY), all Metropolitan Statistical Areas (MSA)
# 2. 'LineCode': integer, 
#                LineCode corresponds to the statistic in a table. It can either 
#                be one value(ie.1,10,11), or ‘ALL’ to retrieve all the
#                statistics for one GeoFips
# (start)119:10, 253: 100, 
# 339: 1000, 367:1001, 
# 381: 1002, 395: 1003
# 409: 1004, 423: 1005, 
# 437: 101, 463: 102, 487: 103
# 119 [CAEMP25N] Total employment
# 120 [CAEMP25S] Total employment
# 140 [SAEMP25N] Total employment
# 141 [SAEMP25S] Total employment
# 186 [CAEMP25N] Total employment
# 187 [CAEMP25S] Total employment
# 207 [SAEMP25N] Total employment
# 208 [SAEMP25S] Total employment
# 253 [CAEMP25N] Private nonfarm employment: Forestry, fishing, and related activities (NAICS:113-115)
# 254 [CAEMP25S] Private nonfarm earnings: Agricultural services, forestry, and fishing (SIC:[07-09])
# 269 [SAEMP25N] Private nonfarm employment: Forestry, fishing, and related activities (NAICS:113-115)
# 270 [SAEMP25S] Private nonfarm employment: Agricultural services, forestry, and fishing (SIC:[07-09])
# 271 [SAEMP27N] Private nonfarm wage and salary employment: Forestry, fishing, and related activities (NAICS:113-115)
# 272 [SAEMP27S] Private nonfarm wage and salary employment: Agricultural services, forestry, and fishing (SIC:[07-09])
# 296 [CAEMP25N] Private nonfarm employment: Forestry, fishing, and related activities (NAICS:113-115)
# 297 [CAEMP25S] Private nonfarm earnings: Agricultural services, forestry, and fishing (SIC:[07-09])
# 312 [SAEMP25N] Private nonfarm employment: Forestry, fishing, and related activities (NAICS:113-115)
# 313 [SAEMP25S] Private nonfarm employment: Agricultural services, forestry, and fishing (SIC:[07-09])
# 314 [SAEMP27N] Private nonfarm wage and salary employment: Forestry, fishing, and related activities (NAICS:113-115)
# 315 [SAEMP27S] Private nonfarm wage and salary employment: Agricultural services, forestry, and fishing (SIC:[07-09])
# 343 [SAEMP25N] Private nonfarm employment: Finance and insurance (NAICS:52)
# 344 [SAEMP27N] Private nonfarm wage and salary employment: Finance and insurance (NAICS:52)
# 357 [SAEMP25N] Private nonfarm employment: Finance and insurance (NAICS:52)
# 358 [SAEMP27N] Private nonfarm wage and salary employment: Finance and insurance (NAICS:52)
# 369 [SAEMP25N] Private nonfarm employment: Monetary Authorities-central bank (NAICS:521)
# 370 [SAEMP27N] Private nonfarm wage and salary employment: Monetary Authorities-central bank (NAICS:521)
# 376 [SAEMP25N] Private nonfarm employment: Monetary Authorities-central bank (NAICS:521)
# 377 [SAEMP27N] Private nonfarm wage and salary employment: Monetary Authorities-central bank (NAICS:521)
# 390 [SAEMP25N] Private nonfarm employment: Credit intermediation and related activities (NAICS:522)
# 391 [SAEMP27N] Private nonfarm wage and salary employment: Credit intermediation and related activities (NAICS:522)
# 397 [SAEMP25N] Private nonfarm employment: Securities, commodity contracts, and other financial investments and related activities (NAICS:523)
# 398 [SAEMP27N] Private nonfarm wage and salary employment: Securities, commodity contracts, and other financial investments and related activities (NAICS:523)
# 411 [SAEMP25N] Private nonfarm employment: Insurance carriers and related activities (NAICS:524)
# 412 [SAEMP27N] Private nonfarm wage and salary employment: Insurance carriers and related activities (NAICS:524)
# 418 [SAEMP25N] Private nonfarm employment: Insurance carriers and related activities (NAICS:524)
# 419 [SAEMP27N] Private nonfarm wage and salary employment: Insurance carriers and related activities (NAICS:524)
# 432 [SAEMP25N] Private nonfarm employment: Funds, trusts, and other financial vehicles (NAICS:525)
# 433 [SAEMP27N] Private nonfarm wage and salary employment: Funds, trusts, and other financial vehicles (NAICS:525)
# 439 [SAEMP25N] Private nonfarm employment: Forestry and logging (NAICS:113)
# 440 [SAEMP27N] Private nonfarm wage and salary employment: Forestry and logging (NAICS:113)
# 452 [SAEMP25N] Private nonfarm employment: Forestry and logging (NAICS:113)
# 453 [SAEMP27N] Private nonfarm wage and salary employment: Forestry and logging (NAICS:113)
# 465 [SAEMP25N] Private nonfarm employment: Fishing, hunting and trapping (NAICS:114)
# 466 [SAEMP27N] Private nonfarm wage and salary employment: Fishing, hunting and trapping (NAICS:114)
# 477 [SAEMP25N] Private nonfarm employment: Fishing, hunting and trapping (NAICS:114)
# 478 [SAEMP27N] Private nonfarm wage and salary employment: Fishing, hunting and trapping (NAICS:114)
# 489 [SAEMP25N] Private nonfarm employment: Support activities for agriculture and forestry (NAICS:115)
# 490 [SAEMP27N] Private nonfarm wage and salary employment: Support activities for agriculture and forestry (NAICS:115)

# 3. 'TableName': string,
#                 CAEMP25N(counties, metros, employment, NAICS), CAEMP25S(S: SIC),
#                 (LineCode): SAEMP25N(SA: States), SAEMP25S,
#                 SAEMP27N(27: wage and salary employment), SAEMP27S
# 4. 'Year': string, ALL

library(bea.R)
library(glue)
bea_key <- '40842C92-E8E2-4A6E-9964-51DADABDD1DE'
dir <- '/Users/jacky/Documents/research/RA/Yang/US_regional_database/employment/rdata'

getData <- function(filename, geoFips, lineCode, table){
    beaSpecs <- list(
    'UserID' = bea_key,
    'Method' = 'GetData',
    'datasetname' = 'Regional',
    'GeoFips' = geoFips,
    'LineCode' = lineCode,
    'TableName' = table,
    'Year' = 'ALL',
    'ResultFormat' = 'json'
    )
  table <- beaGet(beaSpecs, asWide=FALSE)
  if(file.exists(dir) == FALSE){
      dir.create(file.path(dir))
      write.csv(table, glue('{dir}/{filename}.csv'))
  }else{
      write.csv(table, glue('{dir}/{filename}.csv'))
  }
}

getData('CAEMP_N', 'COUNTY', 10, 'CAEMP25N')
getData('CAEMP_S', 'COUNTY', 10, 'CAEMP25S')

getData('MAEMP_N', 'MSA', 10, 'CAEMP25N')
getData('MAEMP_S', 'MSA', 10, 'CAEMP25S')

getData('SAEMP_N', 'STATE', 10, 'SAEMP25N')
getData('SAEMP_S', 'STATE', 10, 'SAEMP25S')