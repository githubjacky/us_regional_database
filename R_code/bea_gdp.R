#install.packages('bea.R')
library(bea.R)
library(glue)

######## config ######## 
beaKey <- '40842C92-E8E2-4A6E-9964-51DADABDD1DE'
localDirectory <<- '/Users/yangyuchen/Desktop/RA/US_GDP'
######################## 

getRegionalData <- function(table, lineCode, geoFips){
  beaSpecs <- list(
    'UserID' = beaKey ,
    'Method' = 'GetData',
    'datasetname' = 'Regional',
    'TableName' = table,
    'LineCode' = lineCode,
    'GeoFips' = geoFips,
    'Year' = 'ALL',
    'ResultFormat' = 'json'
  )
  beaPayload <- beaGet(beaSpecs, asWide = FALSE)
  return(beaPayload)
}

saveFile <- function(filename, table, lineCode, geoFips){
  tempTable <- getRegionalData(table, lineCode, geoFips)
  tempTable <- tempTable[order(GeoFips, TimePeriod),]
  write.csv(tempTable, glue('{localDirectory}/{filename}.csv'))
}

main <- function(){
  tryCatch({dir.create(localDirectory)
            glue('Create new folder {localDirectory}.')},
           warning = function(e)
             {print("Folder already exists.")})
  saveFile('stateQuarterly', 'SQGDP1', '1', 'STATE')
  saveFile('stateAnnually', 'SAGDP1', '1', 'STATE')
  saveFile('countyAnnually', 'CAGDP1', '1', 'COUNTY')
  saveFile('MSAAnnually', 'CAGDP1', '1', 'MSA')
  saveFile('stateAnnually_Nominal_1', 'SAGDP2S', '1', 'STATE')
  saveFile('stateAnnually_Nominal_2', 'SAGDP2N', '1', 'STATE')
  before <- read.csv(glue('{localDirectory}/stateAnnually_Nominal_1.csv'), row.names = 1)
  before <- before[before$TimePeriod != 1997,]
  after <- read.csv(glue('{localDirectory}/stateAnnually_Nominal_2.csv'), row.names = 1)
  after <- subset(after, select = -NoteRef)
  after$GeoName <- replace(after$GeoName, after$GeoName == 'United States *', 'United States')
  all <- rbind(before, after)
  all <- all[order(all$GeoFips, all$TimePeriod),]
  write.csv(all, glue('{localDirectory}/stateAnnually_Nominal.csv'))
}


main()


# STATE, QUARTERLY
# https://apps.bea.gov/api/data/?UserID=40842C92-E8E2-4A6E-9964-51DADABDD1DE&method=GetParameterValuesFiltered&datasetname=Regional&TargetParameter=LineCode&TableName=SQGDP1&ResultFormat=XML
# STATE, ANNUALLY(1963-1997)
# https://apps.bea.gov/api/data/?UserID=40842C92-E8E2-4A6E-9964-51DADABDD1DE&method=GetParameterValuesFiltered&datasetname=Regional&TargetParameter=LineCode&TableName=SAGDP2S&ResultFormat=XML# COUNTY, ANNUALLY
# STATE, ANNUALLY(1997-2021)
# https://apps.bea.gov/api/data/?UserID=40842C92-E8E2-4A6E-9964-51DADABDD1DE&method=GetParameterValuesFiltered&datasetname=Regional&TargetParameter=LineCode&TableName=SAGDP2N&ResultFormat=XML# COUNTY, ANNUALLY
# MSA, ANNUALLY
# https://apps.bea.gov/api/data/?UserID=40842C92-E8E2-4A6E-9964-51DADABDD1DE&method=GetParameterValuesFiltered&datasetname=Regional&TargetParameter=LineCode&TableName=CAGDP1&ResultFormat=XML

