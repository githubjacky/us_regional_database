// merge county annually
use $wdata/CAEMP.dta
merge 1:1 geofips geoname timeperiod using $wdatacountyAnnually.dta
drop _merge
save $wdata/CAEMP_GDP.dta, replace


// merge MSA annually
use $wdata/MAEMP.dta
merge 1:1 geofips geoname timeperiod using $wdata/MSAAnnually.dta
drop _merge
save $wdata/MAEMP_GDP.dta, replace


// merge state annually
use $wdata/SAEMP.dta
merge 1:1 geofips geoname timeperiod using $wdata/stateAnnually_Nominal.dta
rename GDP nominal_GDP
drop _merge
merge 1:1 geofips geoname timeperiod using $wdata/stateAnnually.dta
drop _merge
save $wdata/SAEMP_GDP.dta, replace


// merget the state level welfare data
clear
import excel $rdata/UKCPR_National_Welfare_Data_Update_022322.xlsx, sheet(Data) firstrow
rename year timeperiod
drop BW
save $wdata/welfare.dta, replace

clear
use $wdata/SAEMP_GDP.dta
gen state_fips = geofips / 1000
drop geofips 
merge 1:1 state_fips timeperiod using $wdata/welfare.dta

drop _merge state_name state
gen geofips = state_fips * 1000
drop state_fips
order geofips
order Employment, before(employment)
save $wdata/SAEMP_GDP_WELFARE.dta, replace


